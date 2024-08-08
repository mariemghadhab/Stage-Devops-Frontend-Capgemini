FROM node:12.14.0 AS builder

# Définition du répertoire de travail
WORKDIR /app

# Copie des fichiers nécessaires pour l'installation des dépendances
COPY package.json package-lock.json ./

# Installation des dépendances
RUN npm install

# Copie du reste des fichiers de l'application
COPY . .

# Construction de l'application
RUN npm run build --prod

# Utilisation d'une image nginx légère pour servir l'application
FROM nginx:alpine

# Copie du build de l'application Angular à partir du builder stage
COPY --from=builder /app/dist/crudtuto-Front /usr/share/nginx/html
