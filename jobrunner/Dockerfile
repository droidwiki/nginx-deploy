FROM droidwiki/php-fpm:7.4

WORKDIR /opt/

COPY mwjobrunner mwjobrunner
RUN chmod +x mwjobrunner

USER www-data:www-data
CMD ["/opt/mwjobrunner"]
