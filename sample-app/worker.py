import os
from celery import Celery

#BROKER_URL = 'redis://localhost:6379/0'
#BACKEND_URL = 'redis://localhost:6379/1'
BROKER_URL = 'redis://localhost'
BACKEND_URL = 'redis://localhost'
#os.environ.setdefault('FORKED_BY_MULTIPROCESSING', '1')
app = Celery(
    'celery_web',
    broker=BROKER_URL,
    backend=BACKEND_URL,
    include=['tasks']
)
