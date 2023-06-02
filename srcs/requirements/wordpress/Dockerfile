FROM debian:buster

RUN apt update -y && apt upgrade -y
RUN apt-get -y install wget

RUN apt-get install -y \
php7.3 \
php7.3-fpm \
php7.3-mysql \
php7.3-phar \
php7.3-json \
php7.3-xml \
php7.3-mbstring \
php7.3-curl \
php7.3-gd \
php7.3-intl \
php7.3-zip \
mariadb-client

RUN wget https://fr.wordpress.org/wordpress-6.0-fr_FR.tar.gz -P /var/www
RUN cd /var/www && tar -xzf wordpress-6.0-fr_FR.tar.gz && rm wordpress-6.0-fr_FR.tar.gz
# RUN	chown -R root:root /var/www/wordpress
RUN chown -R www-data:www-data /var/www/wordpress


COPY ./conf/php.conf /etc/php/7.3/fpm/pool.d/www.conf

# wp config cli and config
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

COPY conf/script.sh /script.sh
RUN chmod 777 /script.sh
ENTRYPOINT [ "sh", "/script.sh" ]
