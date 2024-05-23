from rest_framework import routers
from .api import RegistroUsuarioView, UsuarioViewSet, ProyectoViewSet, GroupUsuarioProyectoViewSet
from django.urls import path
router = routers.DefaultRouter()

router.register('usuario', UsuarioViewSet, 'usuario-list')
router.register('proyecto', ProyectoViewSet, 'proyecto-list')

router.register('groupusuarioproyecto', GroupUsuarioProyectoViewSet, 'groupusuarioproyecto-list')

urlpatterns = [
    path('registro/', RegistroUsuarioView.as_view(), name='registro-usuario'),
] + router.urls
