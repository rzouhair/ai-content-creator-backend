# Generated by Django 3.2.18 on 2024-01-09 22:30

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('content_generation', '0002_initial'),
    ]

    operations = [
        migrations.AddField(
            model_name='skill',
            name='examples',
            field=models.TextField(default=''),
        ),
    ]
