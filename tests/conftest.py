import pytest
from django.conf import settings


@pytest.fixture(scope='session')
def django_db_setup():
    """
    Configuration de la base de données pour les tests.
    """
    settings.DATABASES['default'] = {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': ':memory:',
    }
