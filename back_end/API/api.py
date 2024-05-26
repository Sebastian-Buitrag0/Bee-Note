from datetime import datetime
from django.shortcuts import get_object_or_404
from rest_framework.response import Response
from .models import (Persona, Usuario, Registro, Proyecto, Tarea, Recurso, Estado, Tipo, Prioridad, 
                     UsuariosRegistro, RecursoProyecto, RecursoTarea, UsuarioTarea, GroupUsuarioProyecto)
from .serializers import (RegistroUsuarioSerializer, PersonaSerializer, UsuarioSerializer, RegistroSerializer, 
                          GroupSerializer, ProyectoSerializer, TareaSerializer, RecursoSerializer, EstadoSerializer, 
                          TipoSerializer, PrioridadSerializer, UsuariosRegistroSerializer, RecursoProyectoSerializer, 
                          RecursoTareaSerializer, UsuarioTareaSerializer, GroupUsuarioProyectoSerializer)
from rest_framework import viewsets, generics
from rest_framework.permissions import IsAuthenticated, DjangoModelPermissions, AllowAny
from rest_framework.exceptions import PermissionDenied
from django.contrib.auth.models import Group
from rest_framework.decorators import api_view, authentication_classes, permission_classes
from rest_framework import status
from django.db.models import Q
from django.contrib.auth.signals import user_logged_in
from django.dispatch import receiver

@api_view(['POST'])
@authentication_classes([])
@permission_classes([])
def registro(request):
    serializer = RegistroSerializer(data=request.data)
    if serializer.is_valid():
        serializer.save()
        return Response(serializer.data, status=status.HTTP_201_CREATED)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


@receiver(user_logged_in)
def update_last_login(sender, user, request, **kwargs):
    Usuario.objects.filter(pk=user.pk).update(last_login=datetime.now())

class UsuarioViewSet(viewsets.ModelViewSet):
    queryset = Usuario.objects.all()
    permission_classes = [IsAuthenticated, DjangoModelPermissions]
    serializer_class = UsuarioSerializer

    def get_queryset(self):
        usuario = self.request.user
        return Usuario.objects.filter(id=usuario.id)


class ProyectoViewSet(viewsets.ModelViewSet):
    queryset = Proyecto.objects.all()
    serializer_class = ProyectoSerializer
    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        usuario = self.request.user
        return Proyecto.objects.filter(groupusuarioproyecto__idUsuario=usuario)

    def perform_create(self, serializer):
        proyecto = serializer.save()
        usuario = self.request.user
        rol_creador = Group.objects.get(name='Creador')
        GroupUsuarioProyecto.objects.create(idGroup=rol_creador, idUsuario=usuario, idProyecto=proyecto)

    def perform_update(self, serializer):
        proyecto = self.get_object()
        usuario = self.request.user
        if usuario.has_perm('app_name.change_proyecto', proyecto):
            serializer.save()
        else:
            raise PermissionDenied('No tienes permiso para editar este proyecto')

    def perform_destroy(self, instance):
        usuario = self.request.user
        if usuario.has_perm('app_name.delete_proyecto', instance):
            instance.delete()
        else:
            raise PermissionDenied('No tienes permiso para eliminar este proyecto')


class TareaViewSet(viewsets.ModelViewSet):
    queryset = Tarea.objects.all()
    permission_classes = [IsAuthenticated]
    serializer_class = TareaSerializer

    def get_queryset(self):
        usuario = self.request.user
        proyecto_id = self.request.query_params.get('proyecto')

        if proyecto_id:
            proyecto = get_object_or_404(Proyecto, id=proyecto_id, groupusuarioproyecto__idUsuario=usuario)
            return Tarea.objects.filter(proyecto=proyecto)
        else:
            return Tarea.objects.none()

    def create(self, request, *args, **kwargs):
        usuario_actual = request.user
        proyecto_id = request.data.get('proyecto')

        proyecto = get_object_or_404(Proyecto, id=proyecto_id)

        if not GroupUsuarioProyecto.objects.filter(
            idUsuario=usuario_actual,
            idProyecto=proyecto,
            idGroup__permissions__codename='add_tarea'
        ).exists():
            return Response({'error': 'No tienes permiso para agregar tareas a este proyecto'}, status=status.HTTP_403_FORBIDDEN)

        return super().create(request, *args, **kwargs)

    def perform_update(self, serializer):
        tarea = self.get_object()
        usuario = self.request.user
        if usuario.has_perm('app_name.change_tarea', tarea):
            serializer.save()
        else:
            raise PermissionDenied('No tienes permiso para editar esta tarea')

    def perform_destroy(self, instance):
        usuario = self.request.user
        if usuario.has_perm('app_name.delete_tarea', instance):
            instance.delete()
        else:
            raise PermissionDenied('No tienes permiso para eliminar esta tarea')


class GroupUsuarioProyectoViewSet(viewsets.ModelViewSet):
    queryset = GroupUsuarioProyecto.objects.all()
    serializer_class = GroupUsuarioProyectoSerializer
    permission_classes = [IsAuthenticated]

    def create(self, request, *args, **kwargs):
        proyecto_id = request.data.get('idProyecto')
        usuario_id = request.data.get('idUsuario')
        group_id = request.data.get('idGroup')

        try:
            proyecto = Proyecto.objects.get(id=proyecto_id)
            usuario = Usuario.objects.get(id=usuario_id)
            group = Group.objects.get(id=group_id)
        except (Proyecto.DoesNotExist, Usuario.DoesNotExist, Group.DoesNotExist):
            return Response({'error': 'Proyecto, usuario o grupo no encontrado'}, status=status.HTTP_400_BAD_REQUEST)

        GroupUsuarioProyecto.objects.create(idGroup=group, idUsuario=usuario, idProyecto=proyecto)
        return Response({'message': 'Usuario agregado al proyecto correctamente'}, status=status.HTTP_201_CREATED)

class RegistroUsuarioView(generics.CreateAPIView):
    queryset = Usuario.objects.all()
    serializer_class = RegistroUsuarioSerializer
    permission_classes = [AllowAny]


class UsuariosPorInicialView(generics.ListAPIView):
    serializer_class = UsuarioSerializer
    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        inicial = self.request.query_params.get('inicial')
        if inicial:
            queryset = Usuario.objects.filter(nombreUsuario__istartswith=inicial)
        else:
            queryset = Usuario.objects.none()
        return queryset