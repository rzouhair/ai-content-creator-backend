# Generated by Django 3.2.18 on 2024-02-01 23:39

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('keywordresearch', '0003_keywords_metadata'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='keywords',
            name='metadata',
        ),
        migrations.AddField(
            model_name='suggestion',
            name='metadata',
            field=models.JSONField(default=dict),
        ),
    ]
