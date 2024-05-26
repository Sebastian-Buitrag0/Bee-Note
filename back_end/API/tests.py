from django.test import TestCase, Client
from django.contrib.auth.models import User, Group, Permission
from django.urls import reverse
from API.models import Proyecto, Usuario, GroupUsuarioProyecto

class ProyectoViewsTestCase(TestCase):
    def setUp(self):
        # Configurar permisos y usuarios
        self.user_with_permissions = User.objects.create_user(username='user1', password='password')
        self.user_without_permissions = User.objects.create_user(username='user2', password='password')

        # Crear grupo y permisos
        group = Group.objects.create(name='Creador')
        permission = Permission.objects.get(codename='add_groupusuarioproyecto')
        group.permissions.add(permission)

        # Asignar usuario con permisos al grupo
        self.user_with_permissions.groups.add(group)

        # Crear proyecto
        self.proyecto = Proyecto.objects.create(nombre='Proyecto de Prueba')

    def test_agregar_usuario_a_proyecto(self):
        # Iniciar sesión como usuario con permisos
        self.client.login(username='user1', password='password')

        # Intentar agregar un usuario al proyecto (reemplaza con la lógica de tu vista)
        response = self.client.post(reverse('nombre_de_tu_url_para_agregar_usuario_al_proyecto'), {
            'idProyecto': self.proyecto.id,
            'idUsuario': self.user_without_permissions.id,
            'idGroup': 1  # Id del grupo apropiado
        })

        # Verificar que se permita agregar usuario con permisos
        self.assertEqual(response.status_code, 201)  # Código de respuesta HTTP esperado

        # Verificar que se haya creado la relación Usuario-Proyecto adecuadamente
        self.assertTrue(GroupUsuarioProyecto.objects.filter(idProyecto=self.proyecto, idUsuario=self.user_without_permissions).exists())

    def test_sin_permisos_para_agregar_usuario_a_proyecto(self):
        # Iniciar sesión como usuario sin permisos
        self.client.login(username='user2', password='password')

        # Intentar agregar un usuario al proyecto (reemplaza con la lógica de tu vista)
        response = self.client.post(reverse('nombre_de_tu_url_para_agregar_usuario_al_proyecto'), {
            'idProyecto': self.proyecto.id,
            'idUsuario': self.user_without_permissions.id,
            'idGroup': 1  # Id del grupo apropiado
        })

        # Verificar que se prohíba agregar usuario sin permisos
        self.assertEqual(response.status_code, 403)  # Código de respuesta HTTP esperado

        # Verificar que no se haya creado la relación Usuario-Proyecto
        self.assertFalse(GroupUsuarioProyecto.objects.filter(idProyecto=self.proyecto, idUsuario=self.user_without_permissions).exists())
