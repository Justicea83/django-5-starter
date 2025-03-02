import os
from celery import Celery
from datetime import timedelta

os.environ.setdefault("DJANGO_SETTINGS_MODULE", "app.settings")

app = Celery('app')

app.config_from_object('django.conf:settings', namespace='CELERY')

app.autodiscover_tasks()

app.conf.beat_schedule = {
    'logger-every-minute': {
        'task': 'background_jobs.tasks.logger',
        'schedule': timedelta(minutes=1),
    },
}
