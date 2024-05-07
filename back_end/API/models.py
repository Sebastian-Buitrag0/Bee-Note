from django.db import models
from django.contrib.auth.models import AbstractBaseUser, BaseUserManager, PermissionsMixin, Permission

class Persona(models.Model):
    id = models.AutoField(primary_key=True)
    nombre = models.CharField(max_length=64)
    apellido = models.CharField(max_length=64)
    fechaNacimiento = models.DateField()
    telefono = models.BigIntegerField()
    correo = models.EmailField()

    def __str__(self):
        return self.nombre+' '+self.apellido

class UsuarioManager(BaseUserManager):
    def create_user(self, nombreUsuario, password=None, **extra_fields):
        if not nombreUsuario:
            raise ValueError('El nombre de usuario es obligatorio')
        user = self.model(nombreUsuario=nombreUsuario, **extra_fields)
        user.set_password(password)
        user.save(using=self._db)
        return user

    def create_superuser(self, nombreUsuario, password=None, **extra_fields):
        extra_fields.setdefault('is_staff', True)
        extra_fields.setdefault('is_superuser', True)
    
    # Crear una instancia de Persona para asociarla al superusuario
        persona = Persona.objects.create(nombre='Admin', apellido='Admin', fechaNacimiento='1990-01-01', telefono='1234567890', correo='admin@example.com')
    
    # Asociar la instancia de Persona al superusuario
        extra_fields['datosPersonales'] = persona
    
        return self.create_user(nombreUsuario, password, **extra_fields)
    
class Usuario(AbstractBaseUser, PermissionsMixin):
    id = models.AutoField(primary_key=True)
    nombreUsuario = models.CharField(max_length=64, unique=True, null=False, blank=False)
    estado = models.BooleanField(default=True)
    is_staff = models.BooleanField(default=False)
    is_superuser = models.BooleanField(default=False)
    datosPersonales = models.ForeignKey(Persona, on_delete=models.CASCADE)

    USERNAME_FIELD = 'nombreUsuario'

    objects = UsuarioManager()

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

class Rol(models.Model):
    id = models.AutoField(primary_key=True)
    nombre = models.CharField(max_length=32)
    descripcion = models.CharField(max_length=256)
    permisos = models.ManyToManyField(Permission)

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

class RolUsuarioProyecto(models.Model):
    id = models.AutoField(primary_key=True)
    idRol = models.ForeignKey(Rol, on_delete=models.CASCADE)
    idUsuario = models.ForeignKey(Usuario, on_delete=models.CASCADE)
    idProyecto = models.ForeignKey(Proyecto, on_delete=models.CASCADE)

    def __str__(self):
        return self.idRol.nombre+' - '+self.idUsuario.nombreUsuario+' - '+self.idProyecto.nombre
     
class UsuarioTarea(models.Model):
    id = models.AutoField(primary_key=True)
    idUsuario = models.ForeignKey(RolUsuarioProyecto, on_delete=models.CASCADE)
    idTarea = models.ForeignKey(Tarea, on_delete=models.CASCADE)

    def __str__(self):
        return self.idUsuario.nombreUsuario+' -> '+self.idTarea.nombre
