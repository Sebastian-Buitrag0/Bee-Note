# Generated by Django 5.0.4 on 2024-05-05 16:04

import django.db.models.deletion
from django.conf import settings
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('API', '0014_alter_usuariotarea_idusuario'),
    ]

    operations = [
        migrations.AddField(
            model_name='registro',
            name='usuario',
            field=models.ForeignKey(default=None, on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL),
        ),
    ]
