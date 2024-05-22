#!/bin/bash

# Обновление списка пакетов
sudo apt-get update

# Установка Nginx и Snapd
echo "Установка Nginx и Snapd..."
sudo apt-get install -y nginx snapd

# Запуск и добавление Nginx в автозагрузку
sudo systemctl start nginx
sudo systemctl enable nginx

# Установка Certbot через Snap
echo "Установка Certbot через Snap..."
sudo snap install core
sudo snap refresh core
sudo snap install --classic certbot

# Создание символической ссылки для Certbot
sudo ln -s /snap/bin/certbot /usr/bin/certbot

# Установка Docker
echo "Установка Docker..."

# Обновление списка пакетов и установка пакетов для HTTPS
sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg

# Добавление официального GPG ключа Docker
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# Настройка репозитория Docker
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Обновление списка пакетов и установка Docker Engine
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Запуск и добавление Docker в автозагрузку
sudo systemctl start docker
sudo systemctl enable docker

# Установка SSHGuard
echo "Установка SSHGuard..."
sudo apt-get install -y sshguard

# Запуск и добавление SSHGuard в автозагрузку
sudo systemctl start sshguard
sudo systemctl enable sshguard

# Установка и настройка UFW
echo "Установка и настройка UFW..."
sudo apt-get install -y ufw
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow ssh
sudo ufw allow http
sudo ufw allow https
sudo ufw --force enable

echo "Установка завершена!"
