# Generated by Django 5.0.3 on 2024-03-31 03:32

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('API', '0008_remove_usuario_contrasenya_usuario_last_login_and_more'),
    ]

    operations = [
        migrations.AlterField(
            model_name='persona',
            name='telefono',
            field=models.BigIntegerField(),
        ),
    ]