FROM debian:buster

RUN apt-get update && apt-get install -y nginx curl


RUN chmod 755 /var/www/html
RUN chown -R www-data:www-data /var/www/html
COPY conf/unified.conf /etc/nginx/nginx.conf
COPY ssl/cert.pem /etc/nginx/ssl/cert.pem
COPY ssl/key.pem /etc/nginx/ssl/key.pem
COPY index.html /usr/share/nginx/html/

CMD ["nginx", "-g", "daemon off;"]
