from rest_framework import routers
from .api import UsuariosPorInicialView, RegistroUsuarioView, UsuarioViewSet, ProyectoViewSet, GroupUsuarioProyectoViewSet, TareaViewSet
from django.urls import path

router = routers.DefaultRouter()
router.register('usuario', UsuarioViewSet, 'usuario-list')
router.register('proyecto', ProyectoViewSet, 'proyecto-list')
router.register('groupusuarioproyecto', GroupUsuarioProyectoViewSet, 'groupusuarioproyecto-list')
router.register('tarea', TareaViewSet, 'tarea-list')

urlpatterns = [
    path('registro/', RegistroUsuarioView.as_view(), name='registro-usuario'),
    path('usuario/usuarios-inicial/', UsuariosPorInicialView.as_view(), name='usuarios-inicial'),
] + router.urls