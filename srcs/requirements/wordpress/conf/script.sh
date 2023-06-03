#!bin/bash
set -x

# while ! mysqladmin ping -h"${MYSQL_HOSTNAME}" --silent; do
# 	sleep 1
# done

sleep 10

if [ ! -f "/wordpress/wp-activate.php" ]; then
    rm -rf /var/www/wordpress/*

    wp core download \
    --locale="en_US" \
    --allow-root

    wp core config \
    --dbname=$MYSQL_DATABASE \
    --dbuser=$MYSQL_USER \
    --dbpass=$MYSQL_PASSWORD \
    --dbhost=$WP_DB_HOST:3306 \
    --path='/var/www/wordpress' \
    --extra-php \
    --allow-root

    chmod 777 wp-config.php


    wp core install \
    --url=$DOMAIN_NAME \
    --title="WOAH" \
    --admin_user=$MYSQL_USER \
    --admin_password=$MYSQL_PASSWORD \
    --admin_email=$WP_ADMIN_EMAIL\
     --allow-root \
     --path='/var/www/wordpress'

    wp user create \
    --allow-root \
    --role=author $WP_USER $WP_USER_EMAIL \
    --user_pass=$WP_USER_PWD \
    --path='/var/www/wordpress' >> /log.txt
else
    printf "WordPress is installed, skipping installation and launching php-fpm7.3\n"
fi
	

# if /run/php folder does not exist, create it
if [ ! -d /run/php ]; then
    mkdir -p /run/php
fi
/usr/sbin/php-fpm7.3 -F
