# Generated by Django 5.0.3 on 2024-03-31 16:48

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('API', '0009_alter_persona_telefono'),
    ]

    operations = [
        migrations.AlterField(
            model_name='usuario',
            name='estado',
            field=models.BooleanField(default=True),
        ),
    ]