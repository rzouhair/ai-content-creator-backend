# Generated by Django 3.2.18 on 2024-04-05 03:21

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('content_generation', '0008_auto_20240405_0045'),
    ]

    operations = [
        migrations.AlterField(
            model_name='memory',
            name='status',
            field=models.CharField(choices=[('ERROR', 'Error'), ('CREATED', 'Created'), ('PROCESSING', 'Processing'), ('PROCESSED', 'Processed')], default='CREATED', max_length=10),
        ),
        migrations.AlterField(
            model_name='memory',
            name='type',
            field=models.CharField(choices=[('TEXT', 'Text'), ('FILE', 'File'), ('YTB', 'Youtube')], max_length=10),
        ),
    ]