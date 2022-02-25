ARG NODE_VERSION=14.18.2
FROM node:${NODE_VERSION}-alpine AS build

WORKDIR /restbase
RUN apk --no-cache add git python3 make g++ && \
	ln -s /usr/bin/python3 /usr/bin/python && \
    ln -s /usr/bin/pip3 /usr/bin/pip
RUN git clone https://github.com/wikimedia/restbase.git .

RUN npm install

FROM node:${NODE_VERSION}-alpine

COPY --from=build /restbase /restbase

COPY config.yaml /restbase/config.yaml
COPY droidwiki.yaml /restbase/projects/droidwiki.yaml
COPY droidwiki_sys.yaml /restbase/projects/sys/droidwiki.yaml
WORKDIR /restbase
ENV APP_BASE_PATH "/restbase"
EXPOSE 7231

CMD ["node", "/restbase/server.js"]
