# Guide d'Installation Complet - Plateforme E-Learning

Ce document contient tous les codes générés par DeepSeek pour la plateforme e-learning. Suivez les étapes ci-dessous pour installer le projet localement.

## Structure Complète du Projet

```
Projet/
├── README.md                          ✅ Créé
├── database/
│   └── schema.sql                     ✅ Créé
├── backend/
│   ├── package.json
│   ├── .env.example
│   └── src/
│       ├── app.js
│       ├── config/
│       │   └── database.js
│       ├── middleware/
│       │   └── auth.js
│       ├── models/
│       │   └── User.js
│       ├── controllers/
│       │   ├── authController.js
│       │   └── courseController.js
│       ├── routes/
│       │   └── index.js
│       └── services/
│           └── chatbotService.js
└── frontend/
    ├── package.json
    ├── tailwind.config.js
    └── src/
        ├── App.jsx
        ├── contexts/
        │   └── AuthContext.jsx
        └── pages/
            └── learner/
                └── Dashboard.jsx
```

## Étapes d'Installation

### 1. Cloner le Repository

```bash
git clone https://github.com/aggiokevin/Projet.git
cd Projet
```

### 2. Créer la Structure Backend

```bash
mkdir -p backend/src/{config,controllers,middleware,models,routes,services,utils}
```

### 3. Créer le fichier backend/package.json

```json
{
  "name": "e-learning-backend",
  "version": "1.0.0",
  "description": "Backend API pour plateforme e-learning",
  "main": "src/app.js",
  "scripts": {
    "start": "node src/app.js",
    "dev": "nodemon src/app.js",
    "migrate": "node database/migrate.js"
  },
  "dependencies": {
    "express": "^4.18.2",
    "mysql2": "^3.6.0",
    "bcrypt": "^5.1.0",
    "jsonwebtoken": "^9.0.0",
    "cors": "^2.8.5",
    "dotenv": "^16.0.3",
    "express-validator": "^6.15.0",
    "multer": "^1.4.5-lts.1",
    "openai": "^3.2.1",
    "helmet": "^7.0.0",
    "express-rate-limit": "^6.7.0"
  },
  "devDependencies": {
    "nodemon": "^2.0.22"
  }
}
```

### 4. Créer backend/.env.example

```
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=votre_mot_de_passe
DB_NAME=elearning_platform
JWT_SECRET=votre_secret_jwt_complexe_ici
OPENAI_API_KEY=votre_cle_api_openai
PORT=3000
```

### 5. Créer backend/src/app.js

```javascript
const express = require('express');
const cors = require('cors');
const helmet = require('helmet');
const rateLimit = require('express-rate-limit');
require('dotenv').config();

const routes = require('./routes');

const app = express();

// Middleware de sécurité
app.use(helmet());
app.use(cors({
    origin: process.env.FRONTEND_URL || 'http://localhost:3000',
    credentials: true
}));

// Rate limiting
const limiter = rateLimit({
    windowMs: 15 * 60 * 1000, // 15 minutes
    max: 100 // limite à 100 requêtes par windowMs
});
app.use('/api/', limiter);

// Middleware de parsing
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Routes
app.use('/api', routes);

// Route de test
app.get('/health', (req, res) => {
    res.json({ status: 'ok', message: 'Server is running' });
});

// Gestion des erreurs 404
app.use((req, res) => {
    res.status(404).json({ error: 'Route non trouvée' });
});

// Gestion globale des erreurs
app.use((err, req, res, next) => {
    console.error(err.stack);
    res.status(500).json({ error: 'Erreur serveur interne' });
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`✅ Serveur lancé sur le port ${PORT}`);
});

module.exports = app;
```

### 6. Installer les Dépendances Backend

```bash
cd backend
npm install
```

### 7. Configurer la Base de Données

```bash
# Se connecter à MySQL
mysql -u root -p

# Créer la base de données
source ../database/schema.sql

# ou
mysql -u root -p < ../database/schema.sql
```

### 8. Créer Structure Frontend

```bash
cd ../
mkdir -p frontend/src/{components,pages/{auth,learner,trainer,admin},services,contexts,hooks,utils}
```

### 9. Créer frontend/package.json

```json
{
  "name": "e-learning-frontend",
  "version": "1.0.0",
  "private": true,
  "dependencies": {
    "react": "^18.2.0",
    "react-dom": "^18.2.0",
    "react-router-dom": "^6.8.0",
    "axios": "^1.3.0",
    "react-hot-toast": "^2.4.0",
    "react-icons": "^4.7.0",
    "@headlessui/react": "^1.7.0",
    "@heroicons/react": "^2.0.0",
    "date-fns": "^2.29.0",
    "tailwindcss": "^3.2.0"
  },
  "scripts": {
    "start": "react-scripts start",
    "build": "react-scripts build",
    "test": "react-scripts test",
    "eject": "react-scripts eject"
  }
}
```

### 10. Installer les Dépendances Frontend

```bash
cd frontend
npm install
```

### 11. Créer frontend/.env

```
REACT_APP_API_URL=http://localhost:3000/api
```

### 12. Lancer l'Application

#### Terminal 1 - Backend:
```bash
cd backend
npm run dev
```

#### Terminal 2 - Frontend:
```bash
cd frontend
npm start
```

## Prochaines Étapes

Les fichiers suivants doivent encore être créés (code disponible dans la conversation DeepSeek) :

### Backend:
- ✅ `src/config/database.js` 
- ✅ `src/middleware/auth.js`
- ✅ `src/models/User.js`
- ✅ `src/controllers/authController.js`
- ✅ `src/controllers/courseController.js`
- ✅ `src/routes/index.js`
- ✅ `src/services/chatbotService.js`

### Frontend:
- ✅ `src/contexts/AuthContext.jsx`
- ✅ `src/App.jsx`
- ✅ `tailwind.config.js`
- ✅ `src/pages/learner/Dashboard.jsx`

**Tous ces codes sont disponibles dans votre conversation avec DeepSeek.**

## Contacts et Support

Pour toute question, contactez [@aggiokevin](https://github.com/aggiokevin)

---

**Note**: Ce projet est une base complète. Référez-vous à la conversation DeepSeek pour récupérer l'intégralité du code de chaque fichier.
