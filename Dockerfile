FROM php:8.3-fpm-alpine

RUN apk add --no-cache \
        libjpeg-turbo-dev \
        libpng-dev \
        libwebp-dev \
        freetype-dev \
        libzip-dev \
        libxml2-dev \
        icu-dev \
        gettext-dev \
        libxslt-dev && \
        docker-php-ext-configure gd --with-freetype --with-jpeg && \
        docker-php-ext-install -j "$(nproc)" gd && \
        docker-php-ext-install pdo_mysql && \
        docker-php-ext-install mysqli && \
        docker-php-ext-install gettext && \
        docker-php-ext-install zip && \
        docker-php-ext-install xsl

COPY uploads.ini /usr/local/etc/php/conf.d/uploads.ini

CMD sh -c "crond f && php-fpm"
