from django.contrib import admin
from .models import Tipo, Prioridad, Estado, Persona, Usuario, Registro, Permiso, Rol, Proyecto, Tarea, Recurso, UsuariosRegistro, RolPermiso, RecursoProyecto, RecursoTarea, UsuarioTarea, RolUsuarioProyecto

# Register your models here.
admin.site.register(Persona)
admin.site.register(Usuario)
admin.site.register(Registro)
admin.site.register(Permiso)
admin.site.register(Rol)
admin.site.register(Proyecto)
admin.site.register(Tarea)
admin.site.register(Recurso)
admin.site.register(Estado)
admin.site.register(Tipo)
admin.site.register(Prioridad)
admin.site.register(UsuariosRegistro)
admin.site.register(RolPermiso)
admin.site.register(RecursoProyecto)
admin.site.register(RecursoTarea)
admin.site.register(UsuarioTarea)
admin.site.register(RolUsuarioProyecto)
