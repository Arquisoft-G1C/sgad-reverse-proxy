FROM nginx:1.28.0-alpine

# Crear carpeta para certificados SSL
RUN mkdir -p /etc/nginx/ssl

# Copiar certificados generados
COPY certs/reverse-proxy.crt /etc/nginx/ssl/reverse-proxy.crt
COPY certs/reverse-proxy.key /etc/nginx/ssl/reverse-proxy.key

# Copiar la configuración personalizada
COPY nginx.conf /etc/nginx/nginx.conf

# Exponer puertos HTTP y HTTPS
EXPOSE 80 443

# Correr nginx en modo foreground
CMD ["nginx", "-g", "daemon off;"]