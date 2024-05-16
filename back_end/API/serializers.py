from rest_framework import serializers
from django.contrib.auth.hashers import make_password
from django.contrib.auth.models import Group
from .models import Tipo, Prioridad, Estado, Persona, Usuario, Registro, Proyecto, Tarea, Recurso, UsuariosRegistro, RecursoProyecto, RecursoTarea, UsuarioTarea, GroupUsuarioProyecto

class PersonaSerializer(serializers.ModelSerializer):
    class Meta:
        model = Persona
        fields = '__all__'
        read_only_fields = ('id',)

class EstadoSerializer(serializers.ModelSerializer):
    class Meta:
        model = Estado
        fields = '__all__'
        read_only_fields = ('id',)

class TipoSerializer(serializers.ModelSerializer):
    class Meta:
        model = Tipo
        fields = '__all__'
        read_only_fields = ('id',)

class PrioridadSerializer(serializers.ModelSerializer):
    class Meta:
        model = Prioridad
        fields = '__all__'
        read_only_fields = ('id',)

class UsuarioSerializer(serializers.ModelSerializer):
    datosPersonales = PersonaSerializer(many=False, read_only=True)
    class Meta:
        model = Usuario
        fields = '__all__'
        read_only_fields = ('id',)

    def validate_password(self, value: str) -> str:
        return make_password(value)

class RegistroSerializer(serializers.ModelSerializer):
    class Meta:
        model = Registro
        fields = '__all__'
        read_only_fields = ('id','fechaCreacion',)

class GroupSerializer(serializers.ModelSerializer):
    class Meta:
        model = Group
        fields = '__all__'
        read_only_fields = ('id','name','descripcion',)

class ProyectoSerializer(serializers.ModelSerializer):
    estado = serializers.PrimaryKeyRelatedField(queryset=Estado.objects.all())
    class Meta:
        model = Proyecto
        fields = '__all__'
        read_only_fields = ('id','fechaCreacion',)

class TareaSerializer(serializers.ModelSerializer):
    idProyecto = ProyectoSerializer(many=False, read_only=True)
    prioridad = PrioridadSerializer(many=False, read_only=True)
    estado = EstadoSerializer(many=False, read_only=True)
    class Meta:
        model = Tarea
        fields = '__all__'
        read_only_fields = ('id','fechaCreacion',)

class RecursoSerializer(serializers.ModelSerializer):
    class Meta:
        model = Recurso
        fields = '__all__'
        read_only_fields = ('id','fechaSubida','tamaño','contribuidor','link','tipo',)



class UsuariosRegistroSerializer(serializers.ModelSerializer):
    class Meta:
        model = UsuariosRegistro
        fields = '__all__'
        read_only_fields = ('id','idUsuario','idRegistro',)


class RecursoProyectoSerializer(serializers.ModelSerializer):
    idProyecto = ProyectoSerializer(many=False, read_only=True)
    idRecurso = RecursoSerializer(many=False, read_only=True)
    class Meta:
        model = RecursoProyecto
        fields = '__all__'
        read_only_fields = ('id','idProyecto','idRecurso',)

class RecursoTareaSerializer(serializers.ModelSerializer):
    idTarea = TareaSerializer(many=False, read_only=True)
    idRecurso = RecursoSerializer(many=False, read_only=True)
    class Meta:
        model = RecursoTarea
        fields = '__all__'
        read_only_fields = ('id','idTarea','idRecurso',)

class UsuarioTareaSerializer(serializers.ModelSerializer):
    idTarea = TareaSerializer(many=False, read_only=True)
    idUsuario = UsuarioSerializer(many=False, read_only=True)
    class Meta:
        model = UsuarioTarea
        fields = '__all__'
        read_only_fields = ('id','idTarea','idUsuario',)

class GroupUsuarioProyectoSerializer(serializers.ModelSerializer):
    idProyecto = ProyectoSerializer(many=False, read_only=True)
    idGroup = GroupSerializer(many=False, read_only=True)
    idUsuario = UsuarioSerializer(many=False, read_only=True)
    class Meta:
        model = GroupUsuarioProyecto
        fields = '__all__'
        read_only_fields = ('id','idProyecto','idGroup','idUsuario',)

class RegistroUsuarioSerializer(serializers.ModelSerializer):
    datosPersonales = PersonaSerializer()

    class Meta:
        model = Usuario
        fields = ['nombreUsuario', 'password', 'datosPersonales']
        extra_kwargs = {'password': {'write_only': True}}

    def create(self, validated_data):
        datos_personales = validated_data.pop('datosPersonales')
        persona = Persona.objects.create(**datos_personales)
        usuario = Usuario.objects.create(datosPersonales=persona, **validated_data)
        usuario.set_password(validated_data['password'])
        usuario.save()
        return usuario
    