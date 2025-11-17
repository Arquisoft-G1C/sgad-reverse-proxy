# sgad-reverse-proxy
Configuración de Nginx como reverse proxy para el proyecto SGAD. Centraliza el acceso al frontend y API Gateway bajo un único punto de entrada.

--- 

## ✅ Requisitos Previos

- Docker Desktop instalado y corriendo
- Docker Compose instalado

---

## 🛠 Comandos Útiles

### Gestión General

```bash
# Levantar todos los servicios
docker-compose up -d

# Detener todos los servicios
docker-compose down

# Ver el estado de los servicios
docker-compose ps

# Ver logs de todos los servicios
docker-compose logs -f
```

### Comandos Específicos de Nginx

```bash
# Ver logs solo del reverse proxy
docker-compose logs -f nginx

# Reconstruir nginx después de cambios en nginx.conf
docker-compose up -d --build nginx

# Reiniciar solo nginx
docker-compose restart nginx

# Detener solo nginx
docker-compose stop nginx

# Iniciar solo nginx
docker-compose start nginx

# Reconstruir la imagen sin usar capas antiguas.
docker-compose build --no-cache reverse-proxy
docker-compose up -d reverse-proxy

# Testear funcion de limite de peticiones (Windows)
powershell ./tests/rate_limit_test.ps1

# Testear funcion de balanceo de carga (Windows)
powershell ./tests/api_load_test.ps1

# Listar redes de Docker
docker network ls
```
