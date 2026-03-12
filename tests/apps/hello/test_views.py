import pytest
from django.urls import reverse
from django.test import Client


@pytest.mark.django_db
class TestHelloWorldView:
    """
    Tests pour la vue hello_world.
    """

    def test_hello_world_status_code(self):
        """
        Vérifie que la page d'accueil retourne un code 200.
        """
        client = Client()
        response = client.get(reverse('hello:index'))
        assert response.status_code == 200

    def test_hello_world_content(self):
        """
        Vérifie que la page d'accueil contient "Hello world !".
        """
        client = Client()
        response = client.get(reverse('hello:index'))
        assert 'Hello world !' in response.content.decode('utf-8')

    def test_hello_world_template_used(self):
        """
        Vérifie que le bon template est utilisé.
        """
        client = Client()
        response = client.get(reverse('hello:index'))
        assert 'hello/index.html' in [t.name for t in response.templates]
