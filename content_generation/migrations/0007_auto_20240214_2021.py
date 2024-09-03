# Generated by Django 3.2.18 on 2024-02-14 20:21

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('content_generation', '0006_alter_memory_status'),
    ]

    operations = [
        migrations.AddField(
            model_name='skill',
            name='memory_eligible',
            field=models.BooleanField(default=False),
        ),
        migrations.AlterField(
            model_name='memory',
            name='status',
            field=models.CharField(choices=[('ERROR', 'Error'), ('CREATED', 'Created'), ('PROCESSED', 'Processed'), ('PROCESSING', 'Processing')], default='CREATED', max_length=10),
        ),
        migrations.AlterField(
            model_name='memory',
            name='type',
            field=models.CharField(choices=[('FILE', 'File'), ('TEXT', 'Text'), ('YTB', 'Youtube')], max_length=10),
        ),
    ]
