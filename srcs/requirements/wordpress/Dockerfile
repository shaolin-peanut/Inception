FROM debian:buster

RUN apt update -y && apt upgrade -y
RUN apt-get -y install wget

RUN apt-get install -y php7.3 \
php-fpm \
php-mysql \
mariadb-client

# change params
RUN sed -i 's/listen = \/run\/php\/php8.2-fpm.sock/listen = wordpress:9000/' /etc/php/7.3/fpm/pool.d/www.conf
RUN sed -i 's/;clear_env = no/clear_env = no/' /etc/php/7.3/fpm/pool.d/www.conf

RUN wget https://fr.wordpress.org/wordpress-6.0-fr_FR.tar.gz -P /var/www
RUN cd /var/www && tar -xzf wordpress-6.0-fr_FR.tar.gz && rm wordpress-6.0-fr_FR.tar.gz
RUN	chown -R root:root /var/www/wordpress

# wp config cli and config
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

COPY conf/script.sh /script.sh
RUN chmod 777 /script.sh
ENTRYPOINT [ "sh", "/script.sh" ]
