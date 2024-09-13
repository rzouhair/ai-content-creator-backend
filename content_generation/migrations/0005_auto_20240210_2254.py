# Generated by Django 3.2.18 on 2024-02-10 22:54

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('content_generation', '0004_memory'),
    ]

    operations = [
        migrations.AlterField(
            model_name='memory',
            name='status',
            field=models.CharField(choices=[('PROCESSED', 'Processed'), ('CREATED', 'Created'), ('PROCESSING', 'Processing')], default='FILE', max_length=10),
        ),
        migrations.AlterField(
            model_name='memory',
            name='type',
            field=models.CharField(choices=[('TEXT', 'Text'), ('FILE', 'File'), ('YTB', 'Youtube')], max_length=10),
        ),
    ]