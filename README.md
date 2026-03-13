# Hello World Django

![CI](https://github.com/VOTRE-USERNAME/hello/actions/workflows/ci.yml/badge.svg)
![Deploy](https://github.com/VOTRE-USERNAME/hello/actions/workflows/deploy.yml/badge.svg)
![Python](https://img.shields.io/badge/python-3.11.9-blue.svg)
![Django](https://img.shields.io/badge/django-4.2-green.svg)
![License](https://img.shields.io/badge/license-Educational-orange.svg)

Application Django minimaliste avec une page d'accueil "Hello world !", conçue pour l'apprentissage pas à pas de CI/CD avec GitHub Actions.

> **Note** : Remplacez `VOTRE-USERNAME` dans les badges par votre nom d'utilisateur GitHub une fois le repository créé.

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
- Étendre les workflows GitHub Actions

Pour contribuer avec CI/CD :
1. Fork le repository
2. Créez une branche : `git checkout -b feature/ma-fonctionnalite`
3. Committez vos changements : `git commit -m "Ajout: ma fonctionnalité"`
4. Poussez vers la branche : `git push origin feature/ma-fonctionnalite`
5. Ouvrez une Pull Request → Les workflows CI s'exécuteront automatiquement

## 🚀 CI/CD avec GitHub Actions

### Workflows Configurés

#### ✅ CI (Continuous Integration)
**Fichier** : `.github/workflows/ci.yml`

Exécute automatiquement à chaque push ou pull request sur `main` :
- Installation des dépendances
- Exécution des migrations
- Lancement des tests avec pytest
- Génération du rapport de couverture
- Upload des artifacts (rapports HTML/XML)

**Voir le status** : Badge CI en haut du README

#### 🚀 Deploy (Deployment)
**Fichier** : `.github/workflows/deploy.yml`

Déclenché sur :
- Push de tags `v*.*.*` (ex: `v1.0.0`)
- Déclenchement manuel via l'interface GitHub

Étapes :
- Validation de la configuration production
- Vérification des migrations
- Collecte des fichiers statiques
- Préparation au déploiement

**Créer un déploiement** :
```bash
git tag v1.0.0
git push origin v1.0.0
```

### Visualiser les Résultats

1. **Onglet Actions** : Allez sur GitHub → onglet "Actions"
2. **Artifacts** : Téléchargez les rapports de couverture depuis les workflows terminés
3. **Badges** : Les badges en haut du README montrent le status en temps réel

### Documentation Complète

Pour plus de détails sur les workflows, consultez [.github/workflows/README.md](.github/workflows/README.md) qui contient :
- Description détaillée de chaque workflow
- Comment tester les workflows localement
- Exercices d'extension (linting, matrice multi-version, Codecov, etc.)
- Guide de dépannage
- Ressources additionnelles

### Exercices d'Apprentissage CI/CD

1. **Ajouter un workflow de linting** : Créer `lint.yml` pour black, flake8, isort
2. **Matrice de tests** : Tester sur Python 3.10, 3.11, 3.12
3. **Intégrer Codecov** : Visualiser la couverture de code en ligne
4. **Multi-OS** : Tester sur Ubuntu, Windows, macOS
5. **Déploiement réel** : Configurer Heroku, Railway ou Render
6. **GitHub Environments** : Séparer staging et production

Consultez la [documentation des workflows](.github/workflows/README.md) pour les instructions détaillées.

## 📝 Licence

Ce projet est libre d'utilisation pour l'apprentissage.

---

**Version** : 1.0.0  
**Date** : Mars 2026
