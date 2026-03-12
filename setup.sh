#!/bin/bash
# Script de setup pour Linux/Mac
# Ce script initialise l'environnement de développement

set -e

echo "========================================"
echo "Installation de l'application Django Hello"
echo "========================================"
echo ""

# Vérifier si Python est installé
if ! command -v python3 &> /dev/null; then
    echo "ERREUR: Python 3 n'est pas installé"
    echo "Veuillez installer Python 3.11.9 et réessayer"
    exit 1
fi

echo "[1/5] Création de l'environnement virtuel..."
python3 -m venv venv

echo "[2/5] Activation de l'environnement virtuel..."
source venv/bin/activate

echo "[3/5] Mise à jour de pip..."
pip install --upgrade pip

echo "[4/5] Installation des dépendances..."
pip install -r requirements/dev.txt

echo "[5/5] Copie du fichier .env.example vers .env..."
if [ ! -f .env ]; then
    cp .env.example .env
    echo "ATTENTION: N'oubliez pas de modifier le fichier .env avec vos propres valeurs !"
else
    echo "Le fichier .env existe déjà, pas de modification"
fi

echo ""
echo "========================================"
echo "Installation terminée avec succès !"
echo "========================================"
echo ""
echo "Prochaines étapes :"
echo "1. Modifier le fichier .env avec vos propres valeurs"
echo "2. Exécuter : python manage.py migrate"
echo "3. Exécuter : python manage.py runserver"
echo "4. Ouvrir http://localhost:8000/ dans votre navigateur"
echo ""
echo "Pour activer l'environnement virtuel plus tard :"
echo "    source venv/bin/activate"
echo ""
