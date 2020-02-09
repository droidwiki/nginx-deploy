FROM php:7.4-fpm-alpine

ENV MAGICK_HOME=/usr
ENV MEMCACHED_DEPS zlib-dev libmemcached-dev cyrus-sasl-dev

RUN apk add --no-cache --update \
    autoconf \
    g++ \
    make \
    # gd
    freetype-dev \
    libpng-dev \
    libjpeg-turbo-dev \
    # mbstring
    oniguruma-dev \
    # imagick
    imagemagick-dev \
    imagemagick \
    libtool \
    && docker-php-ext-configure gd \
     --with-freetype \
     --with-jpeg \
    && docker-php-ext-install \
    opcache \
    json \
    mbstring \
    mysqli \
    gd \
    && pecl install apcu \
    && docker-php-ext-enable apcu \
    && pecl install redis \
    && docker-php-ext-enable redis \
    && pecl install igbinary \
    && docker-php-ext-enable igbinary \
    && pecl install msgpack \
    && docker-php-ext-enable msgpack \
    && pecl install imagick \
    && docker-php-ext-enable imagick \
    && apk del autoconf g++ libtool make

RUN apk add --no-cache --update \
    libmemcached-libs \
    zlib \
    && apk add --no-cache --update --virtual .memcached-deps $MEMCACHED_DEPS \
    && apk add --no-cache --update --virtual .phpize-deps $PHPIZE_DEPS \
    && pecl install memcached \
    && docker-php-ext-enable memcached \
    # needed by WodPress with Memcache object cache
    && pecl install memcache \
    && docker-php-ext-enable memcache \
    && rm -rf /usr/share/php7 \
    && rm -rf /tmp/* \
    && apk del .memcached-deps .phpize-deps

RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"
COPY config/opcache.ini $PHP_INI_DIR/conf.d/
