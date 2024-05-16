from django.contrib import admin
from .models import Tipo, Prioridad, Estado, Persona, Usuario, Registro,  Proyecto, Tarea, Recurso, UsuariosRegistro, RecursoProyecto, RecursoTarea, UsuarioTarea, GroupUsuarioProyecto

# Register your models here.
admin.site.register(Persona)
admin.site.register(Usuario)
admin.site.register(Registro)
admin.site.register(Proyecto)
admin.site.register(Tarea)
admin.site.register(Recurso)
admin.site.register(Estado)
admin.site.register(Tipo)
admin.site.register(Prioridad)
admin.site.register(UsuariosRegistro)
admin.site.register(RecursoProyecto)
admin.site.register(RecursoTarea)
admin.site.register(UsuarioTarea)
admin.site.register(GroupUsuarioProyecto)
