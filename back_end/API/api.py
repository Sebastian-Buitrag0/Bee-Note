import requests

from rest_framework.response import Response
from .models import Persona, Usuario, Registro, Proyecto, Tarea, Recurso, Estado, Tipo, Prioridad, UsuariosRegistro, RecursoProyecto, RecursoTarea, UsuarioTarea, GroupUsuarioProyecto
from .serializers import  RegistroUsuarioSerializer, PersonaSerializer, UsuarioSerializer, RegistroSerializer, GroupSerializer, ProyectoSerializer, TareaSerializer, RecursoSerializer, EstadoSerializer, TipoSerializer, PrioridadSerializer, UsuariosRegistroSerializer, RecursoProyectoSerializer, RecursoTareaSerializer, UsuarioTareaSerializer, GroupUsuarioProyectoSerializer
from rest_framework import viewsets, generics
from rest_framework.permissions import IsAuthenticated, DjangoModelPermissions, AllowAny
from rest_framework.exceptions import PermissionDenied
from django.contrib.auth.models import Group
from rest_framework import viewsets, status
from django.contrib.auth.models import Group
from rest_framework.decorators import api_view, authentication_classes, permission_classes
from rest_framework.response import Response
from rest_framework import status
from .serializers import RegistroSerializer

@api_view(['POST'])
@authentication_classes([])
@permission_classes([])
def registro(request):
    serializer = RegistroSerializer(data=request.data)
    if serializer.is_valid():
        serializer.save()
        return Response(serializer.data, status=status.HTTP_201_CREATED)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


class UsuarioViewSet(viewsets.ModelViewSet):
    queryset = Usuario.objects.all()
    permission_classes = [IsAuthenticated, DjangoModelPermissions]
    serializer_class = UsuarioSerializer

    def get_queryset(self):
        usuario = self.request.user
        user = Usuario.objects.filter(id=usuario.id)
        return user

class ProyectoViewSet(viewsets.ModelViewSet):
    queryset = Proyecto.objects.all()
    serializer_class = ProyectoSerializer
    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        usuario = self.request.user
        proyectos_usuario = Proyecto.objects.filter(groupusuarioproyecto__idUsuario=usuario)
        return proyectos_usuario

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
    permission_classes = [IsAuthenticated, DjangoModelPermissions]
    serializer_class = TareaSerializer

    def get_queryset(self):
        usuario = self.request.user
        proyectos_usuario = Proyecto.objects.filter(groupusuarioproyecto__idUsuario=usuario)
        return Tarea.objects.filter(idProyecto__in=proyectos_usuario)

    def perform_create(self, serializer):
        proyecto = serializer.validated_data['idProyecto']
        usuario = self.request.user
        if usuario.has_perm('app_name.add_tarea', proyecto):
            serializer.save()
        else:
            raise PermissionDenied('No tienes permiso para crear tareas en este proyecto')

    def perform_update(self, serializer):
        tarea = self.get_object()
        usuario = self.request.user
        if usuario.has_perm('app_name.change_tarea', tarea.idProyecto):
            serializer.save()
        else:
            raise PermissionDenied('No tienes permiso para editar esta tarea')

    def perform_destroy(self, instance):
        usuario = self.request.user
        if usuario.has_perm('app_name.delete_tarea', instance.idProyecto):
            instance.delete()
        else:
            raise PermissionDenied('No tienes permiso para eliminar esta tarea')
        
class GroupUsuarioProyectoViewSet(viewsets.ModelViewSet):
    queryset = GroupUsuarioProyecto.objects.all()
    permission_classes = [IsAuthenticated]
    serializer_class = GroupUsuarioProyectoSerializer

    def get_queryset(self):
        usuario = self.request.user
        proyectos_usuario = Proyecto.objects.filter(groupusuarioproyecto__idUsuario=usuario)
        return GroupUsuarioProyecto.objects.filter(idProyecto__in=proyectos_usuario)

    def create(self, request, *args, **kwargs):
        usuario_actual = request.user
        proyecto_id = request.data.get('idProyecto')
        usuario_id = request.data.get('idUsuario')
        group_id = request.data.get('idGroup')

        try:
            proyecto = Proyecto.objects.get(id=proyecto_id)
            usuario = Usuario.objects.get(id=usuario_id)
            group = Group.objects.get(id=group_id)
        except (Proyecto.DoesNotExist, Usuario.DoesNotExist, Group.DoesNotExist):
            return Response({'error': 'Proyecto, usuario o rol no encontrado'}, status=status.HTTP_400_BAD_REQUEST)

        print(GroupUsuarioProyecto.objects.filter(idUsuario_id__id=usuario_actual.id, idProyecto_id__id=proyecto.id))

        if GroupUsuarioProyecto.objects.filter(
            idUsuario_id__id=usuario_actual.id,
            idProyecto_id__id=proyecto.id,
            idGroup_id__permissions__codename='api.add_groupusuarioproyecto'
        ).exists():
            GroupUsuarioProyecto.objects.create(idGroup=group, idUsuario=usuario, idProyecto=proyecto)
            return Response({'message': 'Usuario agregado al proyecto correctamente'}, status=status.HTTP_201_CREATED)
        else:
            return Response({'error': 'No tienes permiso para agregar usuarios a este proyecto'}, status=status.HTTP_403_FORBIDDEN)
    
    def perform_update(self, serializer):
        group_usuario_proyecto = self.get_object()
        proyecto = group_usuario_proyecto.idProyecto
        usuario_actual = self.request.user

        if usuario_actual.has_perm('API.change_groupusuarioproyecto', proyecto):
            serializer.save()
        else:
            raise PermissionDenied('No tienes permiso para editar roles en este proyecto')

    def perform_destroy(self, instance):
        proyecto = instance.idProyecto
        usuario_actual = self.request.user

        if usuario_actual.has_perm('app_name.delete_groupusuarioproyecto', proyecto):
            instance.delete()
        else:
            raise PermissionDenied('No tienes permiso para eliminar roles en este proyecto')

class RegistroUsuarioView(generics.CreateAPIView):
    queryset = Usuario.objects.all()
    serializer_class = RegistroUsuarioSerializer
    permission_classes = [AllowAny]

