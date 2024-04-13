# Generated by Django 5.0.3 on 2024-03-31 03:25

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('API', '0007_remove_usuario_last_login_remove_usuario_password_and_more'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='usuario',
            name='contrasenya',
        ),
        migrations.AddField(
            model_name='usuario',
            name='last_login',
            field=models.DateTimeField(blank=True, null=True, verbose_name='last login'),
        ),
        migrations.AddField(
            model_name='usuario',
            name='password',
            field=models.CharField(default=1, max_length=128, verbose_name='password'),
            preserve_default=False,
        ),
        migrations.AlterField(
            model_name='usuario',
            name='nombreUsuario',
            field=models.CharField(max_length=64, unique=True),
        ),
    ]
