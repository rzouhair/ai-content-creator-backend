# Generated by Django 3.2 on 2023-04-09 08:00

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('content_generation', '0006_alter_output_payload'),
    ]

    operations = [
        migrations.AlterField(
            model_name='output',
            name='payload',
            field=models.JSONField(blank=True, default=dict),
        ),
    ]