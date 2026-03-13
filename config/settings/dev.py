"""
Development settings.
"""

from .base import *

# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = True

ALLOWED_HOSTS = ['localhost', '127.0.0.1', '*']

# Development apps - copy the list to avoid mutation
INSTALLED_APPS = INSTALLED_APPS + [
    'django_extensions',  # Optional: useful for development
]

# Debug toolbar (optionnel)
if DEBUG:
    try:
        import debug_toolbar # noqa: F401
        INSTALLED_APPS = INSTALLED_APPS + ['debug_toolbar']
        MIDDLEWARE = ['debug_toolbar.middleware.DebugToolbarMiddleware'] + MIDDLEWARE
        INTERNAL_IPS = ['127.0.0.1']
    except ImportError:
        pass
