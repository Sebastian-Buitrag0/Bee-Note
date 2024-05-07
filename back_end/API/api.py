from .models import Persona, Usuario, Registro, Rol, Proyecto, Tarea, Recurso, Estado, Tipo, Prioridad, UsuariosRegistro, RecursoProyecto, RecursoTarea, UsuarioTarea, RolUsuarioProyecto
from .serializers import RegistroUsuarioSerializer,PersonaSerializer, UsuarioSerializer, RegistroSerializer, RolSerializer, ProyectoSerializer, TareaSerializer, RecursoSerializer, EstadoSerializer, TipoSerializer, PrioridadSerializer, UsuariosRegistroSerializer, RecursoProyectoSerializer, RecursoTareaSerializer, UsuarioTareaSerializer, RolUsuarioProyectoSerializer
from rest_framework import viewsets, generics
from rest_framework.permissions import IsAuthenticated, AllowAny
from rest_framework.decorators import api_view
from rest_framework.response import Response
from django.contrib.auth.models import Permission


@api_view(['POST'])
def crear_roles(request):
    roles = [
        {
            'nombre': 'Creador',
            'descripcion': 'Rol de creador',
            'permisos': [
                'api.add_proyecto', 'api.change_proyecto', 'api.delete_proyecto', 'api.view_proyecto',
                'api.add_tarea', 'api.change_tarea', 'api.delete_tarea', 'api.view_tarea',
                'api.add_recurso', 'api.change_recurso', 'api.delete_recurso', 'api.view_recurso',
                'api.add_rolusuarioproyecto', 'api.delete_rolusuarioproyecto', 'api.view_rolusuarioproyecto',
                'api.add_usuariotarea', 'api.delete_usuariotarea', 'api.view_usuariotarea',
            ]
        },
        {
            'nombre': 'Moderador',
            'descripcion': 'Rol de moderador',
            'permisos': [
                'api.view_proyecto',
                'api.add_tarea', 'api.change_tarea', 'api.delete_tarea', 'api.view_tarea',
                'api.add_recurso', 'api.change_recurso', 'api.delete_recurso', 'api.view_recurso',
                'api.add_rolusuarioproyecto', 'api.delete_rolusuarioproyecto', 'api.view_rolusuarioproyecto',
                'api.add_usuariotarea', 'api.delete_usuariotarea', 'api.view_usuariotarea',
            ]
        },
        {
            'nombre': 'Colaborador',
            'descripcion': 'Rol de colaborador',
            'permisos': [
                'api.view_proyecto',
                'api.add_tarea', 'api.change_tarea', 'api.delete_tarea', 'api.view_tarea',
                'api.add_recurso', 'api.change_recurso', 'api.delete_recurso', 'api.view_recurso',
                'api.add_usuariotarea', 'api.delete_usuariotarea', 'api.view_usuariotarea',
            ]
        },
        {
            'nombre': 'Visualizador',
            'descripcion': 'Rol de visualizador',
            'permisos': [
                'api.view_proyecto',
                'api.view_tarea',
                'api.view_recurso',
            ]
        }
    ]

    for rol_data in roles:
        rol = Rol.objects.create(nombre=rol_data['nombre'], descripcion=rol_data['descripcion'])
        permisos = Permission.objects.filter(codename__in=rol_data['permisos'])
        rol.permisos.set(permisos)

    return Response({'message': 'Roles creados exitosamente'})




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

class RolViewSet(viewsets.ModelViewSet):
    queryset = Rol.objects.all()
    permission_classes = [
        IsAuthenticated
    ]
    serializer_class = RolSerializer

class ProyectoViewSet(viewsets.ModelViewSet):
    queryset = Proyecto.objects.all()
    permission_classes = [IsAuthenticated]
    serializer_class = ProyectoSerializer

    def get_queryset(self):
        usuario = self.request.user
        return Proyecto.objects.filter(rolusuarioproyecto__idUsuario=usuario)

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
