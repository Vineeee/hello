# Guide de déploiement sur Render.com

Ce guide vous accompagne étape par étape pour déployer votre application Django "Hello World" sur Render.com.

## 📋 Prérequis

- [ ] Compte GitHub avec votre dépôt `hello` poussé
- [ ] Compte gratuit sur [Render.com](https://render.com)
- [ ] Le code doit être sur une branche `main` ou `master`

## 🚀 Déploiement automatique avec `render.yaml`

Render détectera automatiquement le fichier `render.yaml` et créera tous les services nécessaires.

### Étape 1 : Connecter votre dépôt GitHub

1. Connectez-vous à [dashboard.render.com](https://dashboard.render.com)
2. Cliquez sur **"New +"** → **"Blueprint"**
3. Connectez votre compte GitHub si ce n'est pas déjà fait
4. Sélectionnez le dépôt `hello`
5. Render détectera automatiquement `render.yaml`

### Étape 2 : Configurer les variables d'environnement

Render créera automatiquement :
- ✅ `DATABASE_URL` (depuis la base PostgreSQL)
- ✅ `SECRET_KEY` (générée automatiquement)
- ✅ `DJANGO_SETTINGS_MODULE` (config.settings.prod)

**⚠️ Variable à ajouter manuellement :**

1. Dans le dashboard Render, allez dans votre service web **"hello-django"**
2. Allez dans **Environment** → **Variables**
3. Ajoutez la variable suivante :
   - **Key** : `ALLOWED_HOSTS`
   - **Value** : `hello-django.onrender.com` (remplacez par votre URL exacte)
4. Cliquez sur **"Save Changes"**

> 💡 **Astuce** : Trouvez votre URL Render dans l'onglet "Settings" de votre service

### Étape 3 : Lancer le déploiement

1. Cliquez sur **"Apply"** pour créer les services
2. Render va :
   - 🗄️ Créer la base PostgreSQL `hello-db`
   - 🌐 Créer le service web `hello-django`
   - 🔧 Exécuter `build.sh` (installation, collectstatic, migrations)
   - 🚀 Démarrer Gunicorn

3. Le premier déploiement prend **5-10 minutes**
4. Suivez les logs en temps réel dans l'onglet **"Logs"**

### Étape 4 : Vérifier le déploiement

Une fois le déploiement terminé (statut **"Live"** 🟢) :

1. **Accéder à l'application** :
   - Cliquez sur l'URL fournie (ex : `https://hello-django.onrender.com`)
   - Vous devriez voir la page "Hello world !"

2. **Vérifier l'admin Django** :
   - Allez sur `https://hello-django.onrender.com/admin`
   - Vous devriez voir la page de connexion Django

3. **Créer un superutilisateur** (optionnel) :
   - Dans le dashboard Render → onglet **"Shell"**
   - Exécutez :
     ```bash
     python manage.py createsuperuser
     ```
   - Suivez les instructions interactives

## 🔄 Déploiement automatique

Grâce à `autoDeploy: true` dans `render.yaml`, chaque push sur `main` :
1. ✅ Déclenche automatiquement un nouveau déploiement
2. ✅ Exécute le script `build.sh`
3. ✅ Applique les nouvelles migrations
4. ✅ Redémarre le service

**Workflow recommandé** :
```bash
git add .
git commit -m "Nouvelle fonctionnalité"
git push origin main
# Render déploie automatiquement
```

## 🔐 Configuration des secrets GitHub (optionnel)

Pour utiliser les secrets dans vos workflows GitHub Actions :

1. Allez dans **Settings** → **Secrets and variables** → **Actions**
2. Cliquez sur **"New repository secret"**
3. Ajoutez :
   - `RENDER_API_KEY` : Votre clé API Render (Account Settings → API Keys)
   - `RENDER_SERVICE_ID` : ID du service (visible dans l'URL du dashboard)

## 📊 Surveillance et maintenance

### Logs en temps réel
- Dashboard Render → onglet **"Logs"**
- Filtres : Application logs, Build logs, System logs

### Métriques
- Onglet **"Metrics"** : CPU, RAM, requêtes HTTP, temps de réponse

### Base de données
- Dashboard → service **"hello-db"**
- Connexion via `psql` : cliquez sur **"Connect"** pour la commande

### Backups automatiques
- Render sauvegarde automatiquement PostgreSQL
- Restauration disponible dans l'onglet **"Backups"**

## 🛠️ Troubleshooting

### ❌ Erreur : "Application failed to start"

**Vérifier les logs de build** :
```bash
# Dans les logs Render, cherchez :
- "ModuleNotFoundError" → dépendance manquante
- "SECRET_KEY" → variable d'environnement manquante
- "migrate" errors → problème de migration
```

**Solutions courantes** :
1. Vérifier `requirements/prod.txt` complet
2. Vérifier toutes les variables d'environnement
3. Vérifier que `DATABASE_URL` est correctement liée

### ❌ Erreur : "DisallowedHost at /"

**Cause** : `ALLOWED_HOSTS` mal configuré

**Solution** :
1. Aller dans **Environment** → **Variables**
2. Mettre à jour `ALLOWED_HOSTS` avec l'URL exacte :
   ```
   hello-django.onrender.com
   ```
3. Redémarrer le service : **Manual Deploy** → **"Deploy latest commit"**

### ❌ Fichiers statiques ne chargent pas (CSS/JS)

**Vérifier** :
1. `build.sh` exécute bien `collectstatic` ✅
2. Whitenoise est dans `MIDDLEWARE` (déjà configuré) ✅
3. Logs de build confirment : "X static files copied"

**Si le problème persiste** :
- Vérifier `STATICFILES_STORAGE` dans `settings/prod.py`
- Forcer un rebuild : **Manual Deploy** → **"Clear build cache & deploy"**

### ❌ Base de données vide après déploiement

**Cause** : Migrations non appliquées ou base réinitialisée

**Solution** :
1. Vérifier les logs : chercher "Running migrations"
2. Exécuter manuellement dans le **Shell** Render :
   ```bash
   python manage.py migrate
   ```
3. Recréer le superuser si nécessaire

### 🐌 Application lente sur le plan gratuit

**Limitations du plan Free de Render** :
- Le service s'endort après 15 min d'inactivité
- Premier accès après sommeil : 30-60 secondes de démarrage
- RAM limitée : 512 MB

**Solutions** :
- Passer au plan **Starter** ($7/mois) : pas de sommeil
- Configurer un service de "keep-alive" (ping toutes les 10 min)

## 🔄 Mise à jour de l'application

### Déployer une nouvelle version

**Automatique** (recommandé) :
```bash
# Faire vos modifications
git add .
git commit -m "Ajout d'une nouvelle fonctionnalité"
git push origin main
# Render déploie automatiquement en ~3-5 minutes
```

**Manuel** :
- Dashboard → **Manual Deploy** → **"Deploy latest commit"**

### Rollback à une version précédente

1. Dashboard → onglet **"Events"**
2. Trouvez le déploiement fonctionnel précédent
3. Cliquez sur **"Rollback to this version"**

## 📈 Passer en production

### Recommandations pour un site en production :

1. **Upgrade des plans** :
   - Web Service : `free` → `starter` ($7/mois)
   - Database : `free` → `starter` ($7/mois)
   - Modifier dans `render.yaml` et redéployer

2. **Domaine personnalisé** :
   - Dashboard → **Settings** → **Custom Domain**
   - Ajouter votre domaine (ex: `www.monsite.com`)
   - Configurer les DNS selon les instructions Render

3. **Variables d'environnement supplémentaires** :
   ```
   DEBUG=False  # Déjà configuré
   SECURE_HSTS_SECONDS=31536000  # Déjà configuré
   SENTRY_DSN=<votre-url-sentry>  # Monitoring des erreurs
   ```

4. **Email en production** :
   - Configurer un service SMTP (SendGrid, Mailgun)
   - Ajouter les variables : `EMAIL_HOST`, `EMAIL_PORT`, `EMAIL_HOST_USER`, `EMAIL_HOST_PASSWORD`

5. **Storage des médias** :
   - Utiliser AWS S3 ou Cloudinary pour `MEDIA_ROOT`
   - Installer `django-storages`

## 🔗 Ressources utiles

- [Documentation Render Django](https://render.com/docs/deploy-django)
- [Dashboard Render](https://dashboard.render.com)
- [Status Render](https://status.render.com) - Incidents et maintenance
- [Support Render](https://render.com/docs) - Documentation complète

## ✅ Checklist de déploiement

Avant de déployer en production :

- [ ] `SECRET_KEY` forte générée (50+ caractères)
- [ ] `ALLOWED_HOSTS` configuré correctement
- [ ] `DEBUG=False` (déjà configuré dans prod.py)
- [ ] Toutes les migrations appliquées
- [ ] Fichiers statiques collectés
- [ ] Superuser créé
- [ ] Tests passent en local
- [ ] Base PostgreSQL créée sur Render
- [ ] Variables d'environnement configurées
- [ ] Premier déploiement réussi (statut "Live")
- [ ] URL fonctionne et affiche la page
- [ ] Admin Django accessible

## 🎉 Prochaines étapes

Après un déploiement réussi :

1. **Ajouter des fonctionnalités** à votre application Django
2. **Configurer le monitoring** (Sentry, Rollbar)
3. **Mettre en place des tests** automatisés
4. **Documenter votre API** (si applicable)
5. **Optimiser les performances** (cache Redis, CDN)

---

**Besoin d'aide ?** Consultez les logs Render ou la documentation officielle.
