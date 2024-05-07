from .models import Persona, Usuario, Registro, Rol, Proyecto, Tarea, Recurso, Estado, Tipo, Prioridad, UsuariosRegistro, RecursoProyecto, RecursoTarea, UsuarioTarea, RolUsuarioProyecto
from .serializers import RegistroUsuarioSerializer,PersonaSerializer, UsuarioSerializer, RegistroSerializer, RolSerializer, ProyectoSerializer, TareaSerializer, RecursoSerializer, EstadoSerializer, TipoSerializer, PrioridadSerializer, UsuariosRegistroSerializer, RecursoProyectoSerializer, RecursoTareaSerializer, UsuarioTareaSerializer, RolUsuarioProyectoSerializer
from rest_framework import viewsets, generics
from rest_framework.permissions import IsAuthenticated, AllowAny
from rest_framework.exceptions import PermissionDenied





class PersonaViewSet(viewsets.ModelViewSet):
    queryset = Persona.objects.all()
    permission_classes = [
        IsAuthenticated
    ]
    serializer_class = PersonaSerializer

class UsuarioViewSet(viewsets.ModelViewSet):
    queryset = Usuario.objects.all()
    permission_classes = [
        IsAuthenticated
    ]
    serializer_class = UsuarioSerializer

    def get_queryset(self):
        usuario = self.request.user
        user = Usuario.objects.filter(id=usuario.id)
        return user
    
    
    
    
class RegistroViewSet(viewsets.ModelViewSet):
    queryset = Registro.objects.all()
    permission_classes = [
        IsAuthenticated
    ]
    serializer_class = RegistroSerializer

class RolViewSet(viewsets.ModelViewSet):
    queryset = Rol.objects.all()
    permission_classes = [
        IsAuthenticated
    ]
    serializer_class = RolSerializer

class ProyectoViewSet(viewsets.ModelViewSet):
    queryset = Proyecto.objects.all()
    serializer_class = ProyectoSerializer
    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        usuario = self.request.user
        proyectos_asociados = Proyecto.objects.filter(rolusuarioproyecto__idUsuario=usuario)
        return proyectos_asociados

    def perform_create(self, serializer):
        proyecto = serializer.save()
        usuario = self.request.user
        rol_creador = Rol.objects.get(id=1)
        if not RolUsuarioProyecto.objects.filter(idUsuario=usuario, idProyecto=proyecto).exists():
            RolUsuarioProyecto.objects.create(idRol=rol_creador, idUsuario=usuario, idProyecto=proyecto)

    def perform_update(self, serializer):
        proyecto = self.get_object()
        print(self.request.user.has_perm('change_proyecto', proyecto))
        if self.request.user.has_perm('api.change_proyecto', proyecto):
            serializer.save()
        else:
            raise PermissionDenied('No tienes permiso para editar este proyecto')

    def perform_destroy(self, instance):
        if self.request.user.has_perm('api.delete_proyecto', instance):
            instance.delete()
        else:
            raise PermissionDenied('No tienes permiso para eliminar este proyecto')

class TareaViewSet(viewsets.ModelViewSet):
    queryset = Tarea.objects.all()
    permission_classes = [IsAuthenticated]
    serializer_class = TareaSerializer

    def get_queryset(self):
        usuario = self.request.user
        proyectos_usuario = Proyecto.objects.filter(rolusuarioproyecto__idUsuario=usuario)
        return Tarea.objects.filter(idProyecto__in=proyectos_usuario)

class RecursoViewSet(viewsets.ModelViewSet):
    queryset = Recurso.objects.all()
    permission_classes = [
        IsAuthenticated
    ]
    serializer_class = RecursoSerializer

class EstadoViewSet(viewsets.ModelViewSet):
    queryset = Estado.objects.all()
    permission_classes = [
        IsAuthenticated
    ]
    serializer_class = EstadoSerializer

class TipoViewSet(viewsets.ModelViewSet):
    queryset = Tipo.objects.all()
    permission_classes = [
        IsAuthenticated
    ]
    serializer_class = TipoSerializer

class PrioridadViewSet(viewsets.ModelViewSet):
    queryset = Prioridad.objects.all()
    permission_classes = [
        IsAuthenticated
    ]
    serializer_class = PrioridadSerializer

class UsuariosRegistroViewSet(viewsets.ModelViewSet):
    queryset = UsuariosRegistro.objects.all()
    permission_classes = [
        IsAuthenticated
    ]
    serializer_class = UsuariosRegistroSerializer


class RecursoProyectoViewSet(viewsets.ModelViewSet):
    queryset = RecursoProyecto.objects.all()
    permission_classes = [
        IsAuthenticated
    ]
    serializer_class = RecursoProyectoSerializer

class RecursoTareaViewSet(viewsets.ModelViewSet):
    queryset = RecursoTarea.objects.all()
    permission_classes = [
        IsAuthenticated
    ]
    serializer_class = RecursoTareaSerializer

class UsuarioTareaViewSet(viewsets.ModelViewSet):
    queryset = UsuarioTarea.objects.all()
    permission_classes = [
        IsAuthenticated
    ]
    serializer_class = UsuarioTareaSerializer

class RolUsuarioProyectoViewSet(viewsets.ModelViewSet):
    queryset = RolUsuarioProyecto.objects.all()
    permission_classes = [
        IsAuthenticated
    ]
    serializer_class = RolUsuarioProyectoSerializer

class RegistroUsuarioView(generics.CreateAPIView):
    queryset = Usuario.objects.all()
    serializer_class = RegistroUsuarioSerializer
    permission_classes = [AllowAny]

# Path: API/urls.py
# Compare this snippet from BeeNoteAPI/urls.py:
