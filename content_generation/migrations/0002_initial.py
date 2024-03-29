# Generated by Django 3.2.18 on 2024-01-07 21:36

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ('content_generation', '0001_initial'),
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
        ('keywordresearch', '0001_initial'),
    ]

    operations = [
        migrations.AddField(
            model_name='document',
            name='suggestion',
            field=models.ForeignKey(default=None, null=True, on_delete=django.db.models.deletion.CASCADE, to='keywordresearch.suggestion'),
        ),
        migrations.AddField(
            model_name='document',
            name='user',
            field=models.ForeignKey(db_column='user_id', on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL),
        ),
    ]
