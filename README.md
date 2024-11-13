# Projet Flutter - Gestionnaire de tâches

Ce projet Flutter est un gestionnaire de tâches qui permet à l'utilisateur de :

1. **Gérer les tâches** : L'utilisateur peut ajouter, modifier et supprimer des tâches.
2. **Afficher les tâches** : L'utilisateur peut visualiser ses tâches quotidiennes, mensuelles et dans un calendrier.
3. **Gérer son profil** : L'utilisateur peut consulter et mettre à jour son profil.
4. **S'authentifier** : L'utilisateur peut se connecter et s'inscrire à l'application.

## Structure du projet

Le projet est organisé de la manière suivante :

### Core

Le dossier `core/` contient les éléments suivants :

- `constants/` : Les constantes utilisées dans l'application (API, routes, images, etc.).
- `theme/` : La gestion des thèmes de l'application (clair/sombre).
- `helper/` : Les fonctions utilitaires globales, y compris la gestion de la base de données locale.
- `services/` : Les services pour gérer la logique métier et l'interaction avec les API externes.

### Common

Le dossier `common/` contient les widgets réutilisables et les pages communes de l'application, comme la page d'ajout de tâche et les widgets personnalisés.

### Source

Le dossier `src/` contient la logique principale de l'application :

- `models/` : Les modèles de données utilisés dans l'application (Utilisateur, Tâche, etc.).
- `controller/` : Les contrôleurs gérant la logique métier, y compris l'authentification et l'interaction avec les API.
- `views/` : Les vues définissant l'interface utilisateur, organisées par fonctionnalité (Tâches, Profil, Authentification, Tableau de bord).

## Fonctionnalités principales

1. **Gestion des tâches**
   - Ajout, modification et suppression de tâches
   - Affichage des tâches quotidiennes, mensuelles et dans un calendrier

2. **Gestion du profil utilisateur**
   - Consultation et mise à jour du profil

3. **Authentification**
   - Connexion et inscription des utilisateurs


