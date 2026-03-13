# GitHub Actions Workflows

Ce dossier contient les workflows GitHub Actions pour l'intégration continue (CI) et le déploiement continu (CD) de l'application Django Hello World.

## 📋 Workflows Disponibles

### 1. CI (Continuous Integration) - `ci.yml`

**Objectif** : Exécuter automatiquement les tests à chaque push ou pull request.

**Déclenchement** :
- Push sur la branche `main`
- Pull Request vers la branche `main`

**Étapes** :
1. ✅ Récupération du code
2. 🐍 Configuration de Python 3.11
3. 💾 Cache des dépendances pip (accélère les builds)
4. 📦 Installation des dépendances (`requirements/dev.txt`)
5. 🔄 Exécution des migrations Django
6. 🧪 Exécution des tests avec pytest
7. 📊 Génération du rapport de couverture
8. 📤 Upload des artifacts (rapports HTML et XML)

**Artifacts générés** :
- `coverage-report` : Rapport HTML de couverture (visible dans l'onglet Actions)
- `coverage-xml` : Rapport XML pour intégration avec services externes

**Badge de status** :
```markdown
![CI](https://github.com/VOTRE-USERNAME/hello/actions/workflows/ci.yml/badge.svg)
```

**Tester localement** :
```bash
# Installer les dépendances
pip install -r requirements/dev.txt

# Exécuter les migrations
python manage.py migrate

# Lancer les tests avec coverage
pytest --cov=apps --cov-report=term-missing --cov-report=html
```

---

### 2. Deploy (Deployment) - `deploy.yml`

**Objectif** : Valider la configuration de production et préparer le déploiement.

**Déclenchement** :
- Push de tags matchant `v*.*.*` (ex: `v1.0.0`, `v2.1.3`)
- Déclenchement manuel via l'interface GitHub Actions (workflow_dispatch)

**Étapes** :
1. ✅ Récupération du code
2. 🐍 Configuration de Python 3.11
3. 💾 Cache des dépendances pip
4. 📦 Installation des dépendances de production (`requirements/prod.txt`)
5. 🔍 Vérification de la configuration production (`check --deploy`)
6. 📁 Collecte des fichiers statiques
7. 🔄 Vérification que les migrations sont à jour
8. ℹ️ Affichage des informations de déploiement

**Déclenchement manuel** :
1. Allez dans l'onglet "Actions" sur GitHub
2. Sélectionnez le workflow "Deploy"
3. Cliquez sur "Run workflow"
4. Choisissez l'environnement (staging/production)
5. Cliquez sur "Run workflow"

**Créer et pousser un tag** :
```bash
# Créer un tag
git tag v1.0.0

# Pousser le tag vers GitHub
git push origin v1.0.0

# Ou pousser tous les tags
git push --tags
```

**Tester localement** :
```bash
# Installer les dépendances de production
pip install -r requirements/prod.txt

# Vérifier la configuration production
DJANGO_SETTINGS_MODULE=config.settings.prod python manage.py check --deploy

# Collecter les fichiers statiques
DJANGO_SETTINGS_MODULE=config.settings.prod python manage.py collectstatic --noinput

# Vérifier les migrations
DJANGO_SETTINGS_MODULE=config.settings.prod python manage.py makemigrations --check
```

---

## 🎓 Exercices d'Extension

### Exercice 1 : Ajouter un workflow de linting

Créez un nouveau workflow `lint.yml` pour vérifier la qualité du code :

```yaml
name: Lint

on: [push, pull_request]

jobs:
  black:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-python@v5
        with:
          python-version: '3.11'
      - run: pip install black
      - run: black --check .

  flake8:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-python@v5
        with:
          python-version: '3.11'
      - run: pip install flake8
      - run: flake8 .

  isort:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-python@v5
        with:
          python-version: '3.11'
      - run: pip install isort
      - run: isort --check-only .
```

### Exercice 2 : Matrice de test multi-version Python

Modifiez `ci.yml` pour tester sur plusieurs versions de Python :

```yaml
jobs:
  test:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        python-version: ['3.10', '3.11', '3.12']
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-python@v5
        with:
          python-version: ${{ matrix.python-version }}
      # ... reste des steps
```

### Exercice 3 : Intégrer Codecov

1. Créez un compte sur [codecov.io](https://codecov.io/)
2. Ajoutez votre repository
3. Décommentez la section Codecov dans `ci.yml`
4. Ajoutez le badge Codecov à votre README

### Exercice 4 : Matrice multi-OS

Testez sur plusieurs systèmes d'exploitation :

```yaml
jobs:
  test:
    strategy:
      matrix:
        os: [ubuntu-latest, windows-latest, macos-latest]
    runs-on: ${{ matrix.os }}
    # ... steps
```

### Exercice 5 : Déploiement automatique

1. Choisissez une plateforme (Heroku, Railway, Render, etc.)
2. Configurez les secrets GitHub (API keys, tokens)
3. Décommentez et adaptez le job de déploiement dans `deploy.yml`
4. Testez le déploiement avec un tag

### Exercice 6 : GitHub Environments

1. Créez des environments "staging" et "production" dans GitHub
2. Configurez des protection rules (approbations requises)
3. Ajoutez les secrets spécifiques à chaque environment
4. Utilisez les environments dans le workflow deploy

---

## 🔍 Visualiser les Résultats

### Onglet Actions sur GitHub
1. Allez sur votre repository GitHub
2. Cliquez sur l'onglet "Actions"
3. Vous verrez tous les workflows exécutés
4. Cliquez sur un workflow pour voir les détails

### Télécharger les Artifacts
1. Ouvrez un workflow terminé
2. Scrollez vers le bas jusqu'à "Artifacts"
3. Téléchargez le rapport de couverture
4. Ouvrez `index.html` pour voir le rapport détaillé

### Badges dans le README
Ajoutez des badges pour montrer le status de vos workflows :

```markdown
![CI](https://github.com/USERNAME/REPO/actions/workflows/ci.yml/badge.svg)
![Deploy](https://github.com/USERNAME/REPO/actions/workflows/deploy.yml/badge.svg)
```

---

## 🐛 Dépannage

### Le workflow ne se déclenche pas
- Vérifiez que les fichiers sont dans `.github/workflows/`
- Vérifiez la syntaxe YAML avec [YAML Lint](http://www.yamllint.com/)
- Assurez-vous que vous avez poussé sur la branche `main`

### Les tests échouent sur GitHub mais pas localement
- Vérifiez les variables d'environnement
- Assurez-vous que `requirements/dev.txt` est à jour
- Vérifiez que les fichiers `.env` ne sont pas nécessaires (utiliser `.env.example`)

### Le cache pip ne fonctionne pas
- Vérifiez que le chemin du cache est correct
- La clé de cache doit changer quand `requirements/dev.txt` change
- Parfois il faut attendre quelques runs pour que le cache soit efficace

### Erreur "check --deploy" en production
- Vérifiez que `ALLOWED_HOSTS` est configuré
- Assurez-vous que `SECRET_KEY` est défini (même temporaire pour validation)
- Vérifiez les settings de sécurité dans `config/settings/prod.py`

---

## 📚 Ressources

- [Documentation GitHub Actions](https://docs.github.com/en/actions)
- [Actions Marketplace](https://github.com/marketplace?type=actions)
- [Django Deployment Checklist](https://docs.djangoproject.com/en/4.2/howto/deployment/checklist/)
- [pytest Documentation](https://docs.pytest.org/)
- [Coverage.py Documentation](https://coverage.readthedocs.io/)

---

**Version** : 1.0.0  
**Dernière mise à jour** : Mars 2026
