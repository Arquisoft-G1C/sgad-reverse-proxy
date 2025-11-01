FROM nginx:1.28.0-alpine

# Copiar la configuración personalizada
COPY nginx.conf /etc/nginx/nginx.conf

# Exponer el puerto 80
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
