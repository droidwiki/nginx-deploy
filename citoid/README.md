# droidwiki/citoid

Docker image to run the [MediaWiki citoid service](https://www.mediawiki.org/wiki/Citoid) in a docker container.

## Usage

Simply run the container as usual:

``
docker run droidwiki/citoid
``

By default, the dev configuration of the citoid service will be used as a configuration file.
If you want to add your own one, just create one and link the file as a volume into the container:

``
docker run -v ./path/to/config.yml:/bin/config.yml droidwiki/citoid
``
