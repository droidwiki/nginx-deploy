## Certbot cert update

certbot certonly \
	--dns-rfc2136 \
	--dns-rfc2136-credentials /etc/bind/rfc2136_letsencrypt.ini \
	-d 'go2tech.de' \
	-d '*.go2tech.de' \
	--server https://acme-v02.api.letsencrypt.org/directory \
	--email floriansw@t-online.de \
	--agree-tos \
	--no-eff-email \
	--dry-run
