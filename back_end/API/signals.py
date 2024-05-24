from django.db.models.signals import post_save, post_delete
from django.dispatch import receiver
from .models import Usuario, Proyecto, Tarea, GroupUsuarioProyecto, Registro, Tipo

@receiver(post_save, sender=Usuario)
def registrar_usuario(sender, instance, created, **kwargs):
    tipo, _ = Tipo.objects.get_or_create(nombre='Usuario')
    if created:
        descripcion = f'Se ha creado el usuario {instance.nombreUsuario}.'
    else:
        descripcion = f'Se ha actualizado el usuario {instance.nombreUsuario}.'
    Registro.objects.create(
        tipo=tipo,
        entidadAfectada=instance.id,
        descripcion=descripcion
    )

@receiver(post_delete, sender=Usuario)
def eliminar_usuario(sender, instance, **kwargs):
    tipo, _ = Tipo.objects.get_or_create(nombre='Usuario')
    descripcion = f'Se ha eliminado el usuario {instance.nombreUsuario}.'
    Registro.objects.create(
        tipo=tipo,
        entidadAfectada=instance.id,
        descripcion=descripcion
    )

@receiver(post_save, sender=Proyecto)
def registrar_proyecto(sender, instance, created, **kwargs):
    tipo, _ = Tipo.objects.get_or_create(nombre='Proyecto')
    if created:
        descripcion = f'Se ha creado el proyecto {instance.nombre}.'
    else:
        descripcion = f'Se ha actualizado el proyecto {instance.nombre}.'
    Registro.objects.create(
        tipo=tipo,
        entidadAfectada=instance.id,
        descripcion=descripcion
    )

@receiver(post_delete, sender=Proyecto)
def eliminar_proyecto(sender, instance, **kwargs):
    tipo, _ = Tipo.objects.get_or_create(nombre='Proyecto')
    descripcion = f'Se ha eliminado el proyecto {instance.nombre}.'
    Registro.objects.create(
        tipo=tipo,
        entidadAfectada=instance.id,
        descripcion=descripcion
    )

@receiver(post_save, sender=Tarea)
def registrar_tarea(sender, instance, created, **kwargs):
    tipo, _ = Tipo.objects.get_or_create(nombre='Tarea')
    if created:
        descripcion = f'Se ha creado la tarea {instance.nombre}.'
    else:
        descripcion = f'Se ha actualizado la tarea {instance.nombre}.'
    Registro.objects.create(
        tipo=tipo,
        entidadAfectada=instance.id,
        descripcion=descripcion
    )

@receiver(post_delete, sender=Tarea)
def eliminar_tarea(sender, instance, **kwargs):
    tipo, _ = Tipo.objects.get_or_create(nombre='Tarea')
    descripcion = f'Se ha eliminado la tarea {instance.nombre}.'
    Registro.objects.create(
        tipo=tipo,
        entidadAfectada=instance.id,
        descripcion=descripcion
    )

@receiver(post_save, sender=GroupUsuarioProyecto)
def registrar_group_usuario_proyecto(sender, instance, created, **kwargs):
    tipo, _ = Tipo.objects.get_or_create(nombre='GroupUsuarioProyecto')
    if created:
        descripcion = f'Se ha creado la relación {instance.idGroup.name} - {instance.idUsuario.nombreUsuario} - {instance.idProyecto.nombre}.'
    else:
        descripcion = f'Se ha actualizado la relación {instance.idGroup.name} - {instance.idUsuario.nombreUsuario} - {instance.idProyecto.nombre}.'
    Registro.objects.create(
        tipo=tipo,
        entidadAfectada=instance.id,
        descripcion=descripcion
    )

@receiver(post_delete, sender=GroupUsuarioProyecto)
def eliminar_group_usuario_proyecto(sender, instance, **kwargs):
    tipo, _ = Tipo.objects.get_or_create(nombre='GroupUsuarioProyecto')
    descripcion = f'Se ha eliminado la relación {instance.idGroup.name} - {instance.idUsuario.nombreUsuario} - {instance.idProyecto.nombre}.'
    Registro.objects.create(
        tipo=tipo,
        entidadAfectada=instance.id,
        descripcion=descripcion
    )
