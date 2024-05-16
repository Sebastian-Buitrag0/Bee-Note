from rest_framework import routers
from .api import RegistroUsuarioView,PersonaViewSet, UsuarioViewSet, RegistroViewSet, ProyectoViewSet, TareaViewSet, RecursoViewSet, EstadoViewSet, TipoViewSet, PrioridadViewSet, UsuariosRegistroViewSet, RecursoProyectoViewSet, RecursoTareaViewSet, UsuarioTareaViewSet, GroupUsuarioProyectoViewSet
from django.urls import path
router = routers.DefaultRouter()

router.register('persona', PersonaViewSet, 'persona-list')
router.register('usuario', UsuarioViewSet, 'usuario-list')
router.register('registro', RegistroViewSet, 'registro-list')
router.register('proyecto', ProyectoViewSet, 'proyecto-list')
router.register('tarea', TareaViewSet, 'tarea-list')
router.register('recurso', RecursoViewSet, 'recurso-list')
router.register('estado', EstadoViewSet, 'estado-list')
router.register('tipo', TipoViewSet, 'tipo-list')
router.register('prioridad', PrioridadViewSet, 'prioridad-list')
router.register('usuariosregistro', UsuariosRegistroViewSet, 'usuariosregistro-list')
router.register('recursoproyecto', RecursoProyectoViewSet, 'recursoproyecto-list')
router.register('recursotarea', RecursoTareaViewSet, 'recursotarea-list')
router.register('usuariotarea', UsuarioTareaViewSet, 'usuariotarea-list')
router.register('groupusuarioproyecto', GroupUsuarioProyectoViewSet, 'groupusuarioproyecto-list')

urlpatterns = [
    path('registro/', RegistroUsuarioView.as_view(), name='registro-usuario'),
] + router.urls
