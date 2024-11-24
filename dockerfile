# Étape 1 : Construction de l'image de construction
FROM node:14 AS builder

WORKDIR /app

COPY package.json package-lock.json ./

# Installation des dépendances
RUN npm install --legacy-peer-deps

# Copie du reste des fichiers de l'application
COPY . .

# Construction de l'application
RUN npm run build --prod

# Étape 2 : Construction de l'image finale
FROM nginx:alpine

COPY --from=builder /app/dist /usr/share/nginx/html/crudtuto-Front

# Copier la configuration personnalisée
COPY default.conf /etc/nginx/conf.d/

# Exposition du port 80
EXPOSE 80

# Commande par défaut pour démarrer Nginx
CMD ["nginx", "-g", "daemon off;"]
