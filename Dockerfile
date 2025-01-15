# Étape 1 : Construire l'image de l'application React
FROM node:16-alpine AS build

# Créer un répertoire de travail
WORKDIR /app

# Copier package.json et package-lock.json
COPY package*.json ./

# Installer les dépendances
RUN npm install

# Copier le reste des fichiers du projet
COPY . .

# Étape 2 : Construire l'application React pour la production
RUN npm run build

# Étape 3 : Configurer le serveur pour servir l'application
FROM nginx:alpine

# Copier les fichiers de build dans le répertoire de nginx
COPY --from=build /app/build /usr/share/nginx/html

# Exposer le port 80
EXPOSE 80

# Démarrer nginx en mode détaché
CMD ["nginx", "-g", "daemon off;"]
