# droidwiki/restbase

Docker image to run the [MediaWiki restbase service](https://www.mediawiki.org/wiki/RESTBase) in a docker container.

## Usage

Simply run the container as usual:

``
docker run droidwiki/restbase
``

By default, the dev configuration of the citoid service will be used as a configuration file.
If you want to use your own configuration and/or projects, simply link the files relative to the /restbase directory into the container.
