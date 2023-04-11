## Certbot cert update

certbot certonly \
	--dns-rfc2136 \
	--dns-rfc2136-credentials /etc/bind/rfc2136_letsencrypt.ini \
	-d 'droidwiki.org' \
	-d '*.droidwiki.org' \
	-d 'go2tech.de' \
	-d '*.go2tech.de' \
	-d 'droid.wiki' \
	-d '*.droid.wiki' \
	-d 'droid-wiki.org' \
	-d '*.droid-wiki.org' \
	-d 'armakoth.wiki' \
	-d '*.armakoth.wiki' \
	--server https://acme-v02.api.letsencrypt.org/directory \
	--email florian@go2tech.de \
	--agree-tos \
	--no-eff-email \
	--dry-run
