FROM php:8.3.4-fpm-alpine3.18

ARG COMPOSER_VERSION="2.7.2"
ARG COMPOSER_SUM="049b8e0ed9f264d770a0510858cffbc35401510759edc9a784b3a5c6e020bcac"

RUN set -eux \
    && apk add --no-cache \
        c-client \
        ca-certificates \
        freetds \
        freetype \
        gettext \
        gmp \
        icu-libs \
        imagemagick \
        imap \
        libffi \
        libgmpxx \
        libintl \
        libjpeg-turbo \
        libpng \
        libpq \
        librdkafka \
        libssh2 \
        libstdc++ \
        libtool \
        libxpm \
        libxslt \
        libzip \
        lz4-libs \
        make \
        rabbitmq-c \
        tidyhtml \
        tzdata \
        unixodbc \
        vips \
        yaml \
        zstd-libs \
    && true

RUN set -eux \
    && apk add --no-cache --virtual .build-deps \
        autoconf \
        bzip2-dev \
        cmake \
        curl-dev \
        freetds-dev \
        freetype-dev \
        g++ \
        gcc \
        gettext-dev \
        git \
        gmp-dev \
        icu-dev \
        imagemagick-dev \
        imap-dev \
        krb5-dev \
        libc-dev \
        libjpeg-turbo-dev \
        libpng-dev \
        librdkafka-dev \
        libssh2-dev \
        libwebp-dev \
        libxml2-dev \
        libxpm-dev \
        libxslt-dev \
        libzip-dev \
        lz4-dev \
        openssl-dev \
        pcre-dev \
        pkgconf \
        postgresql-dev \
        rabbitmq-c-dev \
        tidyhtml-dev \
        unixodbc-dev \
        vips-dev \
        yaml-dev \
        zlib-dev \
        zstd-dev

RUN docker-php-ext-configure gd \
        --enable-gd \
        --with-webp \
        --with-jpeg

RUN docker-php-ext-install pdo_pgsql
RUN docker-php-ext-install pgsql

RUN pecl install excimer

RUN set -eux \
    && curl -LO "https://getcomposer.org/download/${COMPOSER_VERSION}/composer.phar" \
    && echo "${COMPOSER_SUM}  composer.phar" | sha256sum -c - \
    && chmod +x composer.phar \
    && mv composer.phar /usr/local/bin/composer \
    && composer --version \
    && true

STOPSIGNAL SIGQUIT

COPY docker/php/conf.d/local.ini /usr/local/etc/php/conf.d/local.ini

WORKDIR /var/www/html
COPY --chown=www-data:www-data . .

EXPOSE 9000

COPY docker/php/entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
