FROM debian:buster

RUN apt-get update -y && apt-get install -y software-properties-common ca-certificates lsb-release apt-transport-https wget curl gnupg
RUN sh -c 'echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list' 

RUN wget -qO - https://packages.sury.org/php/apt.gpg | apt-key add - 
RUN apt-get update -y && apt-get install -y php8.2 && php -v
RUN apt-get install -y php8.2-fpm
RUN mkdir /run/php
RUN sed -i 's/listen = \/run\/php\/php8.2-fpm.sock/listen = 9000/' /etc/php/8.2/fpm/pool.d/www.conf

RUN apt-get install -y wordpress
COPY wp-config.php /usr/share/wordpress/wp-config.php

CMD ["php-fpm8.2", "-F"]
