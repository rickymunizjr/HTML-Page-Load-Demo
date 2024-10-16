#Usar Nginx como imagen base
FROM nginx:alpine

#Copiar los archivos de HTML a la carpeta de Nginx
COPY html /usr/share/nginx/html