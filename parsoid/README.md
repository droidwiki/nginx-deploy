# droidwiki/parsoid

Docker image to run the [MediaWiki parsoid service](https://www.mediawiki.org/wiki/Parsoid) in a docker container.

## Usage

Run the image as usual, however, pass in a parsoid configuration file:

``
docker run -v ./path/to/config.yml:/bin/config.yml droidwiki/parsoid
``
