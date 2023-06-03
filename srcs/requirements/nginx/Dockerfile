FROM debian:buster

# install nginx and utils
RUN apt update -y && apt upgrade -y && apt install nginx vim curl -y

# ssl setup
RUN apt install openssl -y && apt upgrade -y
RUN chmod 755 /etc/ssl && chmod 755 /etc/ssl/certs && chmod 755 /etc/ssl/private
RUN openssl req -newkey rsa:4096 -days 42 -nodes -x509 \
-out /etc/ssl/certs/inception.crt \
-keyout /etc/ssl/private/inception.key \
-subj "/C=CH/ST=IDF/L=Lausanne/O=42/OU=42/CN=${DOMAIN_NAME}/UID=${MYSQL_USER}"

# nginx conf (the -p of mkdir creates all the parent folders missing, at once)
COPY conf/nginx.conf /etc/nginx/nginx.conf

# rights allocation
RUN chmod 755 /var/www/html
RUN chown -R www-data:www-data /var/www/html

# run nginx in daemon
CMD [ "nginx", "-g", "daemon off;"]