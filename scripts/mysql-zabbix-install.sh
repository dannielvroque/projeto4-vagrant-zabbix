#!/bin/bash

set -e  # Para o script ao encontrar um erro

# Atualizar pacotes
sudo apt update && sudo apt upgrade -y

# Instalar MySQL Server
sudo apt install -y mysql-server
sudo systemctl enable --now mysql

# Criar banco de dados para o Zabbix
sudo mysql -u root <<EOF
CREATE DATABASE IF NOT EXISTS zabbix CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;
CREATE USER IF NOT EXISTS 'zabbix'@'localhost' IDENTIFIED BY 'teste123';
GRANT ALL PRIVILEGES ON zabbix.* TO 'zabbix'@'localhost';
ALTER USER 'zabbix'@'localhost' IDENTIFIED WITH mysql_native_password BY 'teste123';
FLUSH PRIVILEGES;
EOF

# Instalar repositório do Zabbix e pacotes necessários
wget -qO zabbix-release.deb https://repo.zabbix.com/zabbix/6.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_6.0-4+ubuntu22.04_all.deb
sudo dpkg -i zabbix-release.deb && rm zabbix-release.deb
sudo apt update
sudo apt install -y zabbix-server-mysql zabbix-frontend-php zabbix-nginx-conf zabbix-agent zabbix-sql-scripts

# Importar esquema do banco de dados do Zabbix
SQL_FILE=$(find /usr/share -name "server.sql.gz" | head -n 1)
if [ -f "$SQL_FILE" ]; then
    zcat "$SQL_FILE" | sudo mysql -u zabbix -p'teste123' zabbix
else
    echo "Erro: Arquivo server.sql.gz não encontrado!" && exit 1
fi

# Configurar Zabbix Server
sudo sed -i 's/# DBPassword=/DBPassword=teste123/' /etc/zabbix/zabbix_server.conf

# Configurar Nginx
sudo sed -i 's/# listen 80;/listen 80;/' /etc/zabbix/nginx.conf
sudo sed -i 's/# server_name example.com;/server_name 0.0.0.0;/' /etc/zabbix/nginx.conf

# Ajustar PHP
PHP_VERSION=$(ls /etc/php | grep -E "^[0-9]+\.[0-9]+$" | sort -V | tail -n 1)
sudo sed -i -E 's/(max_execution_time = )30/\1300/' /etc/php/${PHP_VERSION}/fpm/php.ini
sudo sed -i -E 's/(max_input_time = )60/\1300/' /etc/php/${PHP_VERSION}/fpm/php.ini
sudo sed -i -E 's/(post_max_size = )8M/\116M/' /etc/php/${PHP_VERSION}/fpm/php.ini
sudo sed -i 's/;date.timezone =/date.timezone = America\/Sao_Paulo/' /etc/php/${PHP_VERSION}/fpm/php.ini

# Reiniciar e habilitar serviços
sudo systemctl restart zabbix-server zabbix-agent nginx php${PHP_VERSION}-fpm
sudo systemctl enable zabbix-server zabbix-agent nginx php${PHP_VERSION}-fpm

echo "Instalação concluída com sucesso!"