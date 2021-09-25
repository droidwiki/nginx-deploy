ARG PHP_IMAGE_TAG=8.0.11-fpm-alpine

FROM php:${PHP_IMAGE_TAG} as imagick

ENV IMAGICK_VERSION=c5b8086b5d96c7030e6d4e6ea9a5ef49055d8273

COPY compile_imagick.sh compile_imagick.sh
RUN apk add --no-cache --update autoconf g++ make imagemagick-dev imagemagick libtool \
    && chmod +x compile_imagick.sh \
    && ./compile_imagick.sh \
    && mkdir /artifact/ \
    && mv modules/imagick.* /artifact/

FROM php:${PHP_IMAGE_TAG}

ENV MAGICK_HOME=/usr
ENV MEMCACHED_DEPS zlib-dev libmemcached-dev cyrus-sasl-dev

# pickle for extension management
RUN wget https://github.com/FriendsOfPHP/pickle/releases/latest/download/pickle.phar && \
    chmod +x pickle.phar && \
    mv pickle.phar /usr/local/bin/pickle

COPY --from=imagick /artifact/imagick.* ./
COPY enable_imagick.sh ./

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
    && pickle install apcu \
    && docker-php-ext-enable apcu \
    && pickle install redis \
    && docker-php-ext-enable redis \
    && pickle install igbinary@3.2.1 \
    && docker-php-ext-enable igbinary \
    && pickle install msgpack \
    && chmod +x enable_imagick.sh \
    && ./enable_imagick.sh \
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
