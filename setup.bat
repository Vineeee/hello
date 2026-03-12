@echo off
REM Script de setup pour Windows
REM Ce script initialise l'environnement de développement

echo ========================================
echo Installation de l'application Django Hello
echo ========================================
echo.

REM Vérifier si Python est installé
python --version >nul 2>&1
if errorlevel 1 (
    echo ERREUR: Python n'est pas installé ou n'est pas dans le PATH
    echo Veuillez installer Python 3.11.9 et réessayer
    pause
    exit /b 1
)

echo [1/5] Création de l'environnement virtuel...
python -m venv venv
if errorlevel 1 (
    echo ERREUR: Impossible de créer l'environnement virtuel
    pause
    exit /b 1
)

echo [2/5] Activation de l'environnement virtuel...
call venv\Scripts\activate.bat

echo [3/5] Mise à jour de pip...
python -m pip install --upgrade pip

echo [4/5] Installation des dépendances...
pip install -r requirements\dev.txt
if errorlevel 1 (
    echo ERREUR: Impossible d'installer les dépendances
    pause
    exit /b 1
)

echo [5/5] Copie du fichier .env.example vers .env...
if not exist .env (
    copy .env.example .env
    echo ATTENTION: N'oubliez pas de modifier le fichier .env avec vos propres valeurs !
) else (
    echo Le fichier .env existe déjà, pas de modification
)

echo.
echo ========================================
echo Installation terminée avec succès !
echo ========================================
echo.
echo Prochaines étapes :
echo 1. Modifier le fichier .env avec vos propres valeurs
echo 2. Exécuter : python manage.py migrate
echo 3. Exécuter : python manage.py runserver
echo 4. Ouvrir http://localhost:8000/ dans votre navigateur
echo.
echo Pour activer l'environnement virtuel plus tard :
echo     venv\Scripts\activate
echo.
pause
