# Generated by Django 5.0.3 on 2024-04-05 13:57

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('API', '0012_alter_proyecto_recursos'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='proyecto',
            name='recursos',
        ),
        migrations.RemoveField(
            model_name='tarea',
            name='recurso',
        ),
    ]
