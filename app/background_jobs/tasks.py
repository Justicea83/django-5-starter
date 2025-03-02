import subprocess

from celery import shared_task


@shared_task
def logger():
    try:
        # subprocess.run(['python', 'manage.py', 'command_name'], check=True)
        print('a periodic command ..... ---->>>>>>>')
    except subprocess.CalledProcessError as e:
        # Handle errors in the called subprocess
        print(f'An error occurred when calling expire_subscriptions: {e}')
    except Exception as e:
        print(f'An error occurred expire_subscriptions: {e}')
