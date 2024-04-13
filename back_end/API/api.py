from .models import Persona, Usuario, Registro, Permiso, Rol, Proyecto, Tarea, Recurso, Estado, Tipo, Prioridad, UsuariosRegistro, RolPermiso, RecursoProyecto, RecursoTarea, UsuarioTarea, RolUsuarioProyecto
from .serializers import PersonaSerializer, UsuarioSerializer, RegistroSerializer, PermisoSerializer, RolSerializer, ProyectoSerializer, TareaSerializer, RecursoSerializer, EstadoSerializer, TipoSerializer, PrioridadSerializer, UsuariosRegistroSerializer, RolPermisoSerializer, RecursoProyectoSerializer, RecursoTareaSerializer, UsuarioTareaSerializer, RolUsuarioProyectoSerializer
from rest_framework import viewsets
from rest_framework.permissions import IsAuthenticated

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

class RegistroViewSet(viewsets.ModelViewSet):
    queryset = Registro.objects.all()
    permission_classes = [
        IsAuthenticated
    ]
    serializer_class = RegistroSerializer

class PermisoViewSet(viewsets.ModelViewSet):
    queryset = Permiso.objects.all()
    permission_classes = [
        IsAuthenticated
    ]
    serializer_class = PermisoSerializer

class RolViewSet(viewsets.ModelViewSet):
    queryset = Rol.objects.all()
    permission_classes = [
        IsAuthenticated
    ]
    serializer_class = RolSerializer

class ProyectoViewSet(viewsets.ModelViewSet):
    queryset = Proyecto.objects.all()
    permission_classes = [
        IsAuthenticated
    ]
    serializer_class = ProyectoSerializer

class TareaViewSet(viewsets.ModelViewSet):
    queryset = Tarea.objects.all()
    permission_classes = [
        IsAuthenticated
    ]
    serializer_class = TareaSerializer

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

class RolPermisoViewSet(viewsets.ModelViewSet):
    queryset = RolPermiso.objects.all()
    permission_classes = [
        IsAuthenticated
    ]
    serializer_class = RolPermisoSerializer

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

# Path: API/urls.py
# Compare this snippet from BeeNoteAPI/urls.py:
