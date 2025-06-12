# Etapa 1: build de la app React
FROM node:18 as build

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

RUN npm run build

# Etapa 2: contenedor NGINX para servir los archivos
FROM nginx:stable-alpine

# Copiar configuración personalizada (opcional)
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copiar archivos estáticos de React al directorio que NGINX sirve
COPY --from=build /app/build /usr/share/nginx/html/pagina

# Exponer el puerto 80
EXPOSE 80

# Comando por defecto de NGINX (ya viene por defecto, solo por claridad)
CMD ["nginx", "-g", "daemon off;"]
