#!/bin/bash

# Função para log e visual
function titulo() {
  printf '\n=====================================================\n'
  printf "  %s\n" "$1"
  printf '=====================================================\n\n'
}

# Instalar pacotes essenciais
function instalarDependenciasBase() {
  titulo "Atualizando o sistema e instalando pacotes básicos"
  apt update && apt upgrade -y
  apt install -y curl sudo net-tools apt-transport-https ca-certificates software-properties-common ufw
}

# Instalar Docker + Docker Compose
function instalarDocker() {
  titulo "Instalando Docker e Docker Compose"
  curl -fsSL https://get.docker.com -o get-docker.sh
  sh get-docker.sh
  curl -L "https://github.com/docker/compose/releases/download/v2.24.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  chmod +x /usr/local/bin/docker-compose
}

# Instalar Mosquitto (broker MQTT)
function instalarMosquitto() {
  titulo "Instalando Mosquitto MQTT"
  apt install -y mosquitto mosquitto-clients
  systemctl enable mosquitto
  systemctl start mosquitto
}

# Instalar Nginx
function instalarNginx() {
  titulo "Instalando e iniciando Nginx"
  apt install -y nginx
  systemctl enable nginx
  systemctl start nginx
}

# Configurar Nginx como proxy para o Home Assistant
function configurarProxyNginx() {
  titulo "Configurando proxy reverso para o Home Assistant"
  cat <<EOF > /etc/nginx/sites-available/homeassistant
server {
    listen 80;
    server_name home.seudominio.com;

    location / {
        proxy_pass http://localhost:8123;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }
}
EOF
  ln -s /etc/nginx/sites-available/homeassistant /etc/nginx/sites-enabled/homeassistant
  nginx -t && systemctl reload nginx
}

# Criar e subir container do Home Assistant
function configurarHomeAssistant() {
  titulo "Criando container do Home Assistant"
  mkdir -p /home/homeassistant/config
  mkdir -p /home/homeassistant/volumes

  cat <<EOF > /home/homeassistant/docker-compose.yml
version: "3.9"
services:
  homeassistant:
    container_name: homeassistant
    image: ghcr.io/home-assistant/home-assistant:stable
    volumes:
      - /home/homeassistant/config:/config
    network_mode: host
    restart: unless-stopped
EOF

  docker compose -f /home/homeassistant/docker-compose.yml up -d
}

# Rodar tudo
function executarSetup() {
  instalarDependenciasBase
  instalarDocker
  instalarMosquitto
  instalarNginx
  configurarProxyNginx
  configurarHomeAssistant
}

# Executa o setup automaticamente
executarSetup

titulo "Setup concluído com sucesso!"
echo "Acesse: http://<IP-da-VM> ou configure seu domínio com HTTPS via Cloudflare"
