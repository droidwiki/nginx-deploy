FROM varnish:7.2.1

COPY start.sh /start.sh
COPY default.vcl /etc/varnish/default.vcl

EXPOSE 9131
ENTRYPOINT ["/bin/bash", "/start.sh"]
