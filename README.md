# Hello World Django

Application Django minimaliste avec une page d'accueil "Hello world !", conçue pour l'apprentissage pas à pas de CI/CD avec GitHub Actions.

## 📋 Caractéristiques

- **Framework** : Django 4.2 LTS
- **Python** : 3.11.9 (géré via pyenv)
- **Tests** : pytest et pytest-django
- **Structure modulaire** : Configuration multi-environnements (dev/prod)
- **Prêt pour CI/CD** : Structure optimisée pour GitHub Actions

## 📁 Structure du Projet

```
hello/
├── apps/                      # Applications Django
│   └── hello/                 # App Hello World
│       ├── __init__.py
│       ├── apps.py
│       ├── urls.py
│       └── views.py
├── config/                    # Configuration Django
│   ├── settings/
│   │   ├── __init__.py
│   │   ├── base.py           # Settings communs
│   │   ├── dev.py            # Settings développement
│   │   └── prod.py           # Settings production
│   ├── __init__.py
│   ├── asgi.py
│   ├── urls.py
│   └── wsgi.py
├── requirements/              # Dépendances par environnement
│   ├── base.txt              # Dépendances communes
│   ├── dev.txt               # Dépendances développement
│   └── prod.txt              # Dépendances production
├── static/                    # Fichiers statiques (CSS, JS, images)
├── templates/                 # Templates HTML
│   └── hello/
│       └── index.html
├── tests/                     # Tests
│   ├── apps/
│   │   └── hello/
│   │       └── test_views.py
│   └── conftest.py
├── .env.example               # Template pour variables d'environnement
├── .gitignore                 # Fichiers ignorés par Git
├── .python-version            # Version Python pour pyenv
├── manage.py                  # Script de gestion Django
├── pytest.ini                 # Configuration pytest
└── README.md                  # Ce fichier
```

## 🚀 Installation

### Prérequis

- Python 3.11.9 (via pyenv recommandé)
- Git

### Étapes d'installation

1. **Cloner le repository (si applicable)**
   ```bash
   git clone <url-du-repo>
   cd hello
   ```

2. **Créer et activer l'environnement virtuel**
   
   **Windows :**
   ```bash
   python -m venv venv
   venv\Scripts\activate
   ```
   
   **Linux/Mac :**
   ```bash
   python -m venv venv
   source venv/bin/activate
   ```

3. **Installer les dépendances**
   ```bash
   pip install --upgrade pip
   pip install -r requirements/dev.txt
   ```

4. **Configurer les variables d'environnement**
   ```bash
   cp .env.example .env
   # Éditer .env et changer SECRET_KEY
   ```

5. **Appliquer les migrations**
   ```bash
   python manage.py migrate
   ```

6. **Créer un superutilisateur (optionnel)**
   ```bash
   python manage.py createsuperuser
   ```

7. **Lancer le serveur de développement**
   ```bash
   python manage.py runserver
   ```

8. **Accéder à l'application**
   Ouvrir http://localhost:8000/ dans votre navigateur.

## 🧪 Tests

### Exécuter les tests

```bash
pytest
```

### Avec couverture de code

```bash
pytest --cov=apps --cov-report=html
```

Le rapport de couverture sera généré dans `htmlcov/index.html`.

### Exécuter des tests spécifiques

```bash
# Tous les tests de l'app hello
pytest tests/apps/hello/

# Un test spécifique
pytest tests/apps/hello/test_views.py::TestHelloWorldView::test_hello_world_status_code
```

## 🛠️ Commandes Utiles

### Gestion Django

```bash
# Créer des migrations
python manage.py makemigrations

# Appliquer les migrations
python manage.py migrate

# Créer un superutilisateur
python manage.py createsuperuser

# Collecter les fichiers statiques (pour production)
python manage.py collectstatic

# Lancer le shell Django
python manage.py shell
```

### Qualité du code

```bash
# Formater le code avec black
black .

# Vérifier avec flake8
flake8 .

# Trier les imports
isort .
```

## 🌍 Environnements

### Développement

```bash
# Par défaut, utilise config.settings.dev
python manage.py runserver
```

### Production

```bash
# Définir la variable d'environnement
export DJANGO_SETTINGS_MODULE=config.settings.prod  # Linux/Mac
set DJANGO_SETTINGS_MODULE=config.settings.prod      # Windows

# Ou utiliser .env
python manage.py check --deploy
```

## 📦 Déploiement

### Préparer pour la production

1. Générer une nouvelle `SECRET_KEY`
2. Configurer `ALLOWED_HOSTS` dans `.env`
3. Définir `DEBUG=False`
4. Collecter les fichiers statiques : `python manage.py collectstatic`
5. Utiliser gunicorn comme serveur WSGI

### Exemple avec gunicorn

```bash
pip install -r requirements/prod.txt
gunicorn config.wsgi:application --bind 0.0.0.0:8000
```

## 🤝 Contribuer

Ce projet est conçu pour l'apprentissage. N'hésitez pas à :
- Ajouter de nouvelles fonctionnalités
- Améliorer les tests
- Configurer GitHub Actions pour CI/CD

## 📝 Licence

Ce projet est libre d'utilisation pour l'apprentissage.

## 🎯 Prochaines Étapes (CI/CD)

- [ ] Configurer GitHub Actions pour tests automatiques
- [ ] Ajouter linting automatique (black, flake8)
- [ ] Configurer coverage reports
- [ ] Setup du déploiement automatique
- [ ] Ajouter des badges de status au README

---

**Version** : 1.0.0  
**Date** : Mars 2026
