FROM debian:buster

RUN apt-get update && apt-get install -y nginx curl


RUN chmod -R 755 /var/www/
RUN chown -R www-data:www-data /var/www/
COPY conf/unified.conf /etc/nginx/nginx.conf
COPY ssl/cert.pem /etc/nginx/ssl/cert.pem
COPY ssl/key.pem /etc/nginx/ssl/key.pem

CMD ["nginx", "-g", "daemon off;"]
