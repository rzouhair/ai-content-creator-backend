# celery.py (in your Django project)
from __future__ import absolute_import, unicode_literals

import os
from celery import Celery
from django.conf import settings

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'django_project.settings')
app = Celery('django_project')

app.config_from_object('django.conf:settings', namespace='CELERY')
app.autodiscover_tasks(lambda: settings.INSTALLED_APPS)