# Generated by Django 3.2.18 on 2024-04-05 00:45

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('content_generation', '0007_auto_20240214_2021'),
    ]

    operations = [
        migrations.AlterField(
            model_name='memory',
            name='status',
            field=models.CharField(choices=[('ERROR', 'Error'), ('PROCESSING', 'Processing'), ('PROCESSED', 'Processed'), ('CREATED', 'Created')], default='CREATED', max_length=10),
        ),
        migrations.AlterField(
            model_name='memory',
            name='type',
            field=models.CharField(choices=[('YTB', 'Youtube'), ('FILE', 'File'), ('TEXT', 'Text')], max_length=10),
        ),
    ]