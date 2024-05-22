#!/bin/bash

# Функция для проверки наличия ошибок и остановки скрипта в случае их возникновения
check_error() {
    if [ $? -ne 0 ]; then
        echo "Ошибка выполнения команды. Скрипт остановлен."
        exit 1
    fi
}

# Проверка наличия параметра
if [ -z "$1" ]; then
    # Запрос названия домена, если параметр не указан
    read -p "Введите название домена: " DOMAIN
else
    # Использование параметра в качестве названия домена
    DOMAIN=$1
fi

# Добавление конфигурации для домена в Nginx
NGINX_CONF="/etc/nginx/sites-available/default"
sudo bash -c "cat >> $NGINX_CONF" <<EOL

server {
    listen 80;
    listen [::]:80;

    server_name $DOMAIN www.$DOMAIN;

    root /var/www/$DOMAIN;
    index index.html;

    location / {
        try_files \$uri \$uri/ =404;
    }
}
EOL

# Создание директории для домена и пример файла index.html
sudo mkdir -p /var/www/$DOMAIN
sudo bash -c "echo '<html><head><title>Welcome to $DOMAIN!</title></head><body><h1>Success! The $DOMAIN server block is working!</h1></body></html>' > /var/www/$DOMAIN/index.html"

# Проверка конфигурации Nginx и перезапуск
sudo nginx -t
check_error

sudo systemctl reload nginx
check_error

# Запуск Certbot для получения SSL сертификата
sudo certbot --nginx -d $DOMAIN -d www.$DOMAIN
check_error

# Проверка автоматического обновления сертификатов
sudo certbot renew --dry-run
check_error

echo "Настройка домена $DOMAIN завершена успешно!"
