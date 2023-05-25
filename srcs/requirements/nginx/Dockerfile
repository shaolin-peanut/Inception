# FROM debian:buster

# RUN apt-get update && apt-get install -y nginx curl


# RUN chmod -R 755 /var/www/
# RUN chown -R www-data:www-data /var/www/
# COPY conf/unified.conf /etc/nginx/nginx.conf
# COPY ssl/cert.pem /etc/nginx/ssl/cert.pem
# COPY ssl/key.pem /etc/nginx/ssl/key.pem

# CMD ["nginx", "-g", "daemon off;"]

FROM alpine:3.15

ARG DOMAIN_NAME

RUN apk update && \
    apk add --no-cache \
        nginx \
        openssl \
        curl \
    && rm -rf /var/cache/apk/*

COPY conf/nginx.conf /etc/nginx/nginx.conf

EXPOSE 443

# start nginx ("-g" to pass the command "deamon off;" to nginx be run in the foreground
CMD ["nginx", "-g", "daemon off;"]