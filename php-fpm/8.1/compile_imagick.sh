#!/bin/sh
set -e

curl -fsSL https://github.com/Imagick/imagick/archive/$IMAGICK_VERSION.tar.gz | tar xvz --strip 1
phpize
./configure
make
