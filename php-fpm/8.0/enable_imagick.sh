#!/bin/sh
set -e

extDir="$(php -d 'display_errors=stderr' -r 'echo ini_get("extension_dir");')"

mv ./imagick.* "$extDir"
docker-php-ext-enable imagick
