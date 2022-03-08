ARG PHP_IMAGE_TAG=8.1.0-fpm-alpine

FROM php:${PHP_IMAGE_TAG}

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
	# SyntaxHighlight_GeSHi
	python3 \
    # gd
    freetype-dev \
    libpng-dev \
    libjpeg-turbo-dev \
    # mbstring
    oniguruma-dev \
    # imagick
	libgomp \
    imagemagick \
    imagemagick-dev \
    imagemagick-libs \
    libtool \
    # zip extension
    libzip-dev \
    # php ext intl
    icu-dev \
    && docker-php-ext-configure gd \
     --with-freetype \
     --with-jpeg \
    && docker-php-ext-configure intl \
    && docker-php-ext-install \
    opcache \
    mbstring \
    mysqli \
    gd \
    sockets \
    zip \
    intl \
	sockets \
	calendar \
    && pickle install imagick \
    && docker-php-ext-enable imagick \
    && pickle install apcu \
    && docker-php-ext-enable apcu \
    && pickle install redis \
    && docker-php-ext-enable redis \
    && pickle install igbinary \
    && docker-php-ext-enable igbinary \
    && pickle install msgpack \
    && docker-php-ext-enable msgpack \
    && apk del autoconf g++ libtool make

RUN apk add --no-cache --update \
    libmemcached-libs \
    zlib \
    && apk add --no-cache --update --virtual .memcached-deps $MEMCACHED_DEPS \
    && apk add --no-cache --update --virtual .phpize-deps $PHPIZE_DEPS \
    && pickle install memcached \
    && docker-php-ext-enable memcached \
    && rm -rf /tmp/* \
    && apk del .memcached-deps .phpize-deps

RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"
COPY config/* $PHP_INI_DIR/conf.d/
