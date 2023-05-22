FROM debian:buster

RUN apt-get update && apt-get install -y nginx curl

COPY conf/unified.conf /etc/nginx/conf.d/default.conf
# COPY conf/nginx.conf /etc/nginx/conf.d/http.conf
# COPY conf/wordpress.conf /etc/nginx/
COPY ssl/cert.pem /etc/nginx/ssl/cert.pem
COPY ssl/key.pem /etc/nginx/ssl/key.pem
COPY index.html /usr/share/nginx/html/

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]
