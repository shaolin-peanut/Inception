#!/bin/sh
# set -e
set -x

mkdir -p /var/www/wordpress
cd /var/www/wordpress
rm -rf *

until nc -z mariadb 3306; do
  echo "Waiting for MariaDB to start..."
  sleep 1
done

if [ ! -f "wp-config.php" ]; then

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar 
chmod +x wp-cli.phar 
mv wp-cli.phar /usr/local/bin/wp

wp core download --allow-root
rm /var/www/wordpress/wp-config-sample.php
sudo wp config create --dbname=$MYSQL_DATABASE --dbuser=$MYSQL_USER --dbpass=$MYSQL_PASSWORD --dbhost=mariadb

wp core install --url=$DOMAIN_NAME/ --title=$WP_TITLE --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PWD --admin_email=$WP_ADMIN_EMAIL --skip-email --allow-root
wp user create $WP_USER $WP_USER_EMAIL --role=author --user_pass=$WP_USER_PWD --allow-root
wp theme install astra --activate --allow-root
wp plugin update --all --allow-root
sed -i 's/listen = 127.0.0.1:9000/listen = 9000/g' /etc/php8/php-fpm.d/www.conf
mkdir /run/php

fi

/usr/sbin/php-fpm8 -F