# Generated by Django 3.2.18 on 2024-01-06 06:19

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('app_auth', '__first__'),
        ('keywordresearch', '0008_auto_20240106_0603'),
    ]

    operations = [
        migrations.AddField(
            model_name='article',
            name='user',
            field=models.ForeignKey(db_column='user_id', default='e3e03983-bf5c-4c52-8ad8-c0f809cb353c', on_delete=django.db.models.deletion.CASCADE, to='app_auth.user', to_field='_id'),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='keywords',
            name='user',
            field=models.ForeignKey(db_column='user_id', default='e3e03983-bf5c-4c52-8ad8-c0f809cb353c', on_delete=django.db.models.deletion.CASCADE, to='app_auth.user', to_field='_id'),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='search',
            name='user',
            field=models.ForeignKey(db_column='user_id', default='e3e03983-bf5c-4c52-8ad8-c0f809cb353c', on_delete=django.db.models.deletion.CASCADE, to='app_auth.user', to_field='_id'),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='suggestion',
            name='user',
            field=models.ForeignKey(db_column='user_id', default='e3e03983-bf5c-4c52-8ad8-c0f809cb353c', on_delete=django.db.models.deletion.CASCADE, to='app_auth.user', to_field='_id'),
            preserve_default=False,
        ),
    ]
