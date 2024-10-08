# Generated by Django 3.2.18 on 2024-04-05 03:33

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('content_generation', '0010_auto_20240405_0331'),
    ]

    operations = [
        migrations.AlterField(
            model_name='memory',
            name='status',
            field=models.CharField(choices=[('CREATED', 'Created'), ('PROCESSING', 'Processing'), ('PROCESSED', 'Processed'), ('ERROR', 'Error')], default='CREATED', max_length=10),
        ),
        migrations.AlterField(
            model_name='memory',
            name='type',
            field=models.CharField(choices=[('YTB', 'Youtube'), ('FILE', 'File'), ('TEXT', 'Text')], max_length=10),
        ),
    ]
