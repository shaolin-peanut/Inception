#!bin/bash
set -x

sleep 10
cat /var/www/wordpress/wp-config.php
if [ ! -e /var/www/wordpress/wp-config.php ]; then
    wp config create --allow-root \
        --dbname=$MYSQL_DATABASE \
        --dbuser=$MYSQL_USER \
        --dbpass=$MYSQL_PASSWORD \
        --dbhost=mariadb:3306 \
        --path='/var/www/wordpress'


    sleep 2
    wp core install     --url=$DOMAIN_NAME --title="WOAH" --admin_user=$MYSQL_USER --admin_password=$MYSQL_PASSWORD --admin_email=$WP_ADMIN_EMAIL --allow-root --path='/var/www/wordpress'
    wp user create      --allow-root --role=author $WP_USER $WP_USER_EMAIL --user_pass=$WP_USER_PWD --path='/var/www/wordpress' >> /log.txt
fi
	

# if /run/php folder does not exist, create it
if [ ! -d /run/php ]; then
    mkdir ./run/php
fi
/usr/sbin/php-fpm7.3 -F

# echo "define( 'CONCATENATE_SCRIPTS', false );" >> /var/www/wordpress/wp-config.php
# echo "define( 'SCRIPT_DEBUG', true );" >> /var/www/wordpress/wp-config.php
# echo "define( 'WP_HOME', 'https://jcluzet.42.fr' );" >> /var/www/wordpress/wp-config.php
# echo "define( 'WP_SITEURL', 'https://jcluzet.42.fr' );" >> /var/www/wordpress/wp-config.php

# echo "define( 'WP_DEBUG', true);" >> /var/www/wordpress/wp-config.php
# echo "define( 'WP_DEBUG_LOG', true);" >> /var/www/wordpress/wp-config.php
# echo "define( 'WP_DEBUG_DISPLAY', false);" >> /var/www/wordpress/wp-config.php
# echo "define('WP_ALLOW_REPAIR', true);" >> /var/www/wordpress/wp-config.php