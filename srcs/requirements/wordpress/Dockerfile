FROM alpine:3.15

RUN apk update && \
    apk add --no-cache \
    php8 \
    php8-phar \
    php8-fpm \
    php8-mysqli \
    php8-json \
    php8-curl \
    php8-dom \
    php8-xml \
    php8-iconv \
    php8-xmlreader \
    php8-xmlwriter \
    php8-tokenizer \
    php8-simplexml \
    mariadb-client \
    netcat-openbsd \
    curl && \
    rm -rf /var/cache/apk/* && \
    ln -s /usr/bin/php8 /usr/bin/php

COPY ./conf/script.sh /script.sh
RUN chmod +x /script.sh

CMD ["sh", "/script.sh"]