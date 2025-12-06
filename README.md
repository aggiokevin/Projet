# Plateforme E-Learning pour l'Insertion Professionnelle

## Description

Plateforme complète de e-learning permettant aux personnes en insertion professionnelle de suivre des parcours de formation numériques, d'être évaluées, accompagnées par des tuteurs et assistées par un chatbot IA.

## Technologies Utilisées

### Backend
- Node.js & Express.js
- MySQL
- JWT pour l'authentification
- bcrypt pour le hachage des mots de passe
- OpenAI API pour le chatbot

### Frontend
- React 18
- React Router v6
- Tailwind CSS
- Axios
- React Hot Toast

## Fonctionnalités Principales

### Pour les Apprenants
- Inscription et connexion sécurisée
- Navigation dans le catalogue de formations
- Inscription aux cours
- Suivi de la progression
- Réalisation de quiz et exercices
- Chatbot IA pour l'assistance

### Pour les Formateurs
- Création et gestion de cours
- Organisation en modules et leçons
- Création de quiz
- Suivi des apprenants
- Feedback personnalisé

### Pour les Administrateurs
- Gestion des utilisateurs
- Gestion globale des cours
- Tableaux de bord et statistiques
- Configuration de la plateforme

## Structure du Projet

```
e-learning-platform/
├── backend/
│   ├── src/
│   │   ├── config/
│   │   ├── controllers/
│   │   ├── middleware/
│   │   ├── models/
│   │   ├── routes/
│   │   ├── services/
│   │   └── utils/
│   └── package.json
├── frontend/
│   ├── src/
│   │   ├── components/
│   │   ├── pages/
│   │   ├── services/
│   │   ├── contexts/
│   │   └── hooks/
│   └── package.json
└── database/
    └── schema.sql
```

## Installation

### Prérequis
- Node.js (v16 ou supérieur)
- MySQL (v8 ou supérieur)
- Clé API OpenAI

### Backend

```bash
cd backend
npm install

# Créer un fichier .env avec les variables suivantes:
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=votre_mot_de_passe
DB_NAME=elearning_platform
JWT_SECRET=votre_secret_jwt
OPENAI_API_KEY=votre_cle_api_openai

# Créer la base de données
mysql -u root -p < ../database/schema.sql

# Lancer le serveur
npm run dev
```

### Frontend

```bash
cd frontend
npm install

# Créer un fichier .env
REACT_APP_API_URL=http://localhost:3000/api

# Lancer l'application
npm start
```

## Utilisation

1. Accédez à l'application via `http://localhost:3000`
2. Créez un compte ou connectez-vous
3. Explorez le catalogue de cours
4. Inscrivez-vous à un cours
5. Suivez les modules et leçons
6. Utilisez le chatbot pour obtenir de l'aide

## Rôles Utilisateurs

- **TRAINEE** (Apprenant) : Accès aux cours, progression, quiz
- **TRAINER** (Formateur) : Création de cours, suivi des apprenants
- **ADMIN** (Administrateur) : Gestion complète de la plateforme

## Sécurité

- Authentification JWT
- Mots de passe hashés avec bcrypt
- Validation des entrées
- Protection CORS
- Rate limiting

## Auteur

Kevin Aggio (@aggiokevin)

## Licence

Ce projet est sous licence MIT.
