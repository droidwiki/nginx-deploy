## Certbot cert update

certbot certonly \
	--dns-cloudflare \
	--dns-cloudflare-credentials /data/ha_volume/bind/cloudflare.ini \
	-d 'go2tech.de' \
	-d '*.go2tech.de' \
	--server https://acme-v02.api.letsencrypt.org/directory \
	--email floriansw@t-online.de \
	--agree-tos \
	--no-eff-email \
	--dry-run
