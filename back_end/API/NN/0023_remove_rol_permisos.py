# Generated by Django 5.0.4 on 2024-05-10 15:51

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('API', '0022_auto_20240510_1308'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='rol',
            name='permisos',
        ),
    ]
