#!/usr/bin/env bash
# exit on error
set -o errexit

echo "🔧 Installation des dépendances Python..."
pip install --upgrade pip
pip install -r requirements/prod.txt

echo "📦 Collecte des fichiers statiques..."
python manage.py collectstatic --no-input

echo "🗄️  Application des migrations de base de données..."
python manage.py migrate --no-input

echo "✅ Build terminé avec succès!"
