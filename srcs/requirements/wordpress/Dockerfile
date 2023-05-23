FROM debian:buster

RUN apt-get update -y && apt-get install -y software-properties-common ca-certificates lsb-release apt-transport-https wget curl gnupg vim
RUN sh -c 'echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list' 

RUN wget -qO - https://packages.sury.org/php/apt.gpg | apt-key add - 
RUN apt-get update -y && apt-get install -y php8.2 && php -v
RUN apt-get install -y php8.2-fpm


# RUN apt-get install -y wordpress
RUN wget https://fr.wordpress.org/wordpress-6.0-fr_FR.tar.gz -P /var/www
RUN cd /var/www && tar -xzf wordpress-6.0-fr_FR.tar.gz && rm wordpress-6.0-fr_FR.tar.gz
RUN chmod -R 755 /var/www/
RUN	chown -R root:root /var/www/
RUN chown -R www-data:www-data /var/www/wordpress
COPY conf/wp-config.php /var/www/wordpress/wp-config.php

RUN mkdir /run/php
RUN sed -i 's/listen = \/run\/php\/php8.2-fpm.sock/listen = wordpress:9000/' /etc/php/8.2/fpm/pool.d/www.conf
RUN sed -i 's/;clear_env = no/clear_env = no/' /etc/php/8.2/fpm/pool.d/www.conf

CMD ["php-fpm8.2", "-F"]
