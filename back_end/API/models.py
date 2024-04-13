from django.db import models
from django.contrib.auth.models import AbstractBaseUser, BaseUserManager


class Persona(models.Model):
    id = models.AutoField(primary_key=True)
    nombre = models.CharField(max_length=64)
    apellido = models.CharField(max_length=64)
    fechaNacimiento = models.DateField()
    telefono = models.BigIntegerField()
    correo = models.EmailField()

    def __str__(self):
        return self.nombre+' '+self.apellido


class Usuario(AbstractBaseUser):
    id = models.AutoField(primary_key=True)
    nombreUsuario = models.CharField(max_length=64, unique=True, null=False, blank=False)
    estado = models.BooleanField(default=True)
    datosPersonales = models.ForeignKey(Persona, on_delete=models.CASCADE)

    USERNAME_FIELD = 'nombreUsuario'

    objects = BaseUserManager()

    def __str__(self):
        return self.nombreUsuario

class Tipo(models.Model):
    id = models.AutoField(primary_key=True)
    nombre = models.CharField(max_length=64)

    def __str__(self):
        return self.nombre

class Registro(models.Model):
    id = models.AutoField(primary_key=True)
    tipo = models.ForeignKey(Tipo, on_delete=models.CASCADE)
    entidadAfectada = models.IntegerField()
    descripcion = models.CharField(max_length=256)
    fechaRegistro = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.tipo+' -> '+self.entidadAfectada

class Permiso(models.Model):
    id = models.AutoField(primary_key=True)
    nombre = models.CharField(max_length=64)

    def __str__(self):
        return self.nombre


class Rol(models.Model):
    id = models.AutoField(primary_key=True)
    nombre = models.CharField(max_length=32)
    descripcion = models.CharField(max_length=256)

    def __str__(self):
        return self.nombre

class Estado(models.Model):
    id = models.AutoField(primary_key=True)
    nombre = models.CharField(max_length=32)
    descripcion = models.CharField(max_length=256)

    def __str__(self):
        return self.nombre
    
class Prioridad(models.Model):
    id = models.AutoField(primary_key=True)
    nombre = models.CharField(max_length=32)
    descripcion = models.CharField(max_length=256)

    def __str__(self):
        return self.nombre

class Recurso(models.Model):
    id = models.AutoField(primary_key=True)
    nombre = models.CharField(max_length=64)
    tipo = models.CharField(max_length=64)
    link = models.CharField(max_length=256)
    tamaño = models.BinaryField()
    contribuidor = models.ForeignKey(Usuario, on_delete=models.CASCADE)
    fechaSubida = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.nombre+' - '+self.tipo+' - '+self.contribuidor.nombreUsuario


class Proyecto(models.Model):
    id = models.AutoField(primary_key=True)
    nombre = models.CharField(max_length=128)
    descripcion = models.CharField(max_length=512)
    estado = models.ForeignKey(Estado, on_delete=models.CASCADE)
    fechaCreacion = models.DateTimeField(auto_now_add=True)
    fechaInicio = models.DateTimeField()
    fechaFin = models.DateTimeField()

    def __str__(self):
        return self.nombre
    
class Tarea(models.Model):
    id = models.AutoField(primary_key=True)
    idProyecto = models.ForeignKey(Proyecto, on_delete=models.CASCADE)
    nombre = models.CharField(max_length=128)
    descripcion = models.CharField(max_length=512)
    estado = models.ForeignKey(Estado, on_delete=models.CASCADE)
    prioridad = models.ForeignKey(Prioridad, on_delete=models.CASCADE)
    fechaCreacion = models.DateTimeField(auto_now_add=True)
    fechaInicio = models.DateTimeField()
    fechaFin = models.DateTimeField()

    def __str__(self):
        return 'Proyecto: '+self.idProyecto.nombre+'-> '+self.nombre

class UsuariosRegistro(models.Model):
    id = models.AutoField(primary_key=True)
    idUsuario = models.ForeignKey(Usuario, on_delete=models.CASCADE)
    idRegistro = models.ForeignKey(Registro, on_delete=models.CASCADE)

    def __str__(self):
        return self.idUsuario.nombreUsuario+' -> '+self.idRegistro.tipo

class RolPermiso(models.Model):
    id = models.AutoField(primary_key=True)
    idRol = models.ForeignKey(Rol, on_delete=models.CASCADE)
    idPermiso = models.ForeignKey(Permiso, on_delete=models.CASCADE)

    def __str__(self):
        return self.idRol.nombre+' -> '+self.idPermiso.tipo


class RecursoProyecto(models.Model):
    id = models.AutoField(primary_key=True)
    idRecurso = models.ForeignKey(Recurso, on_delete=models.CASCADE)
    idProyecto = models.ForeignKey(Proyecto, on_delete=models.CASCADE)

    def __str__(self):
        return self.idRecurso.nombre+' -> '+self.idProyecto.nombre


class RecursoTarea(models.Model):
    id = models.AutoField(primary_key=True)
    idRecurso = models.ForeignKey(Recurso, on_delete=models.CASCADE)
    idTarea = models.ForeignKey(Tarea, on_delete=models.CASCADE)

    def __str__(self):
        return self.idRecurso.nombre+' -> '+self.idTarea.nombre

class UsuarioTarea(models.Model):
    id = models.AutoField(primary_key=True)
    idUsuario = models.ForeignKey(Usuario, on_delete=models.CASCADE)
    idTarea = models.ForeignKey(Tarea, on_delete=models.CASCADE)

    def __str__(self):
        return self.idUsuario.nombreUsuario+' -> '+self.idTarea.nombre

class RolUsuarioProyecto(models.Model):
    id = models.AutoField(primary_key=True)
    idRol = models.ForeignKey(Rol, on_delete=models.CASCADE)
    idUsuario = models.ForeignKey(Usuario, on_delete=models.CASCADE)
    idProyecto = models.ForeignKey(Proyecto, on_delete=models.CASCADE)

    def __str__(self):
        return self.idRol.nombre+' - '+self.idUsuario.nombreUsuario+' - '+self.idProyecto.nombre

