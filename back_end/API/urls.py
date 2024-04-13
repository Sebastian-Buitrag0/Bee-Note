from rest_framework import routers
from .api import PersonaViewSet, UsuarioViewSet, RegistroViewSet, PermisoViewSet, RolViewSet, ProyectoViewSet, TareaViewSet, RecursoViewSet, EstadoViewSet, TipoViewSet, PrioridadViewSet, UsuariosRegistroViewSet, RolPermisoViewSet, RecursoProyectoViewSet, RecursoTareaViewSet, UsuarioTareaViewSet, RolUsuarioProyectoViewSet

router = routers.DefaultRouter()

router.register('persona', PersonaViewSet, 'persona-list')
router.register('usuario', UsuarioViewSet, 'usuario-list')
router.register('registro', RegistroViewSet, 'registro-list')
router.register('permiso', PermisoViewSet, 'permiso-list')
router.register('rol', RolViewSet, 'rol-list')
router.register('proyecto', ProyectoViewSet, 'proyecto-list')
router.register('tarea', TareaViewSet, 'tarea-list')
router.register('recurso', RecursoViewSet, 'recurso-list')
router.register('estado', EstadoViewSet, 'estado-list')
router.register('tipo', TipoViewSet, 'tipo-list')
router.register('prioridad', PrioridadViewSet, 'prioridad-list')
router.register('usuariosregistro', UsuariosRegistroViewSet, 'usuariosregistro-list')
router.register('rolpermiso', RolPermisoViewSet, 'rolpermiso-list')
router.register('recursoproyecto', RecursoProyectoViewSet, 'recursoproyecto-list')
router.register('recursotarea', RecursoTareaViewSet, 'recursotarea-list')
router.register('usuariotarea', UsuarioTareaViewSet, 'usuariotarea-list')
router.register('rolusuarioproyecto', RolUsuarioProyectoViewSet, 'rolusuarioproyecto-list')

urlpatterns = router.urls
