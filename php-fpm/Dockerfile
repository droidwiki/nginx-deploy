FROM php:8.0.0RC3-fpm-alpine

ENV MAGICK_HOME=/usr
ENV MEMCACHED_DEPS zlib-dev libmemcached-dev cyrus-sasl-dev

# pickle for extension management
RUN wget https://github.com/FriendsOfPHP/pickle/releases/latest/download/pickle.phar && \
    chmod +x pickle.phar && \
    mv pickle.phar /usr/local/bin/pickle

RUN apk add --no-cache --update \
    autoconf \
    g++ \
    make \
    # Scribunto extension
    lua \
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
    # zip extension
    libzip-dev \
    && docker-php-ext-configure gd \
     --with-freetype \
     --with-jpeg \
    && docker-php-ext-install \
    opcache \
    mbstring \
    mysqli \
    gd \
    sockets \
    zip \
    && pickle install apcu \
    && docker-php-ext-enable apcu \
    && pickle install redis \
    && docker-php-ext-enable redis \
    && pickle install igbinary \
    && docker-php-ext-enable igbinary \
    && pickle install msgpack \
    && docker-php-ext-enable msgpack \
    && pickle install imagick \
    && docker-php-ext-enable imagick \
    && apk del autoconf g++ libtool make

RUN apk add --no-cache --update \
    libmemcached-libs \
    zlib \
    && apk add --no-cache --update --virtual .memcached-deps $MEMCACHED_DEPS \
    && apk add --no-cache --update --virtual .phpize-deps $PHPIZE_DEPS \
    && pickle install memcached \
    && docker-php-ext-enable memcached \
    # needed by WodPress with Memcache object cache
    && pickle install memcache \
    && docker-php-ext-enable memcache \
    && rm -rf /usr/share/php7 \
    && rm -rf /tmp/* \
    && apk del .memcached-deps .phpize-deps

RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"
COPY config/opcache.ini $PHP_INI_DIR/conf.d/
