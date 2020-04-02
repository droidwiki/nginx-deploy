FROM droidwiki/php-fpm

RUN docker-php-ext-install pcntl

WORKDIR /opt/
RUN apk add --no-cache --update git \
    && git clone https://github.com/wikimedia/mediawiki-services-jobrunner.git jobrunner \
    && apk del git

COPY config config
USER www-data:www-data
CMD ["/usr/local/bin/php", "/opt/jobrunner/redisJobRunnerService", "--config-file=/opt/config/jobrunner.conf"]
