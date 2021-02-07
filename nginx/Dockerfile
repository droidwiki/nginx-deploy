ARG NGINX_VERSION=1.19.6
FROM nginx:${NGINX_VERSION}-alpine AS release

COPY conf/ /etc/nginx/conf.d/
COPY includes/ /etc/nginx/includes/
COPY dhparam.pem /etc/nginx/ssl/dhparam.pem

FROM nginx:${NGINX_VERSION}-alpine AS test
COPY --from=release / /
RUN apk add --no-cache --no-progress openssl
RUN mkdir -p /etc/nginx/certs/droidwiki.org && \
    openssl req -nodes -x509 -newkey rsa:4096 \
     -keyout /etc/nginx/certs/droidwiki.org/privkey.pem \
     -out /etc/nginx/certs/droidwiki.org/fullchain.pem \
     -days 365 \
     -subj "/C=DE/ST=No/L=City/O=A/OU=A/CN=www.example.com/emailAddress=dev@www.example.com"
RUN echo "127.0.0.1 php" >> /etc/hosts && \
    echo "127.0.0.1 php-canary" >> /etc/hosts && \
    echo "127.0.0.1 cache" >> /etc/hosts && \
    echo "127.0.0.1 eclair.dwnet" >> /etc/hosts && \
    echo "127.0.0.1 escape-statistics-backend" >> /etc/hosts && \
    echo "127.0.0.1 escape-statistics-frontend" >> /etc/hosts && \
    nginx -t

FROM release
