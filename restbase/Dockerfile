FROM node:alpine AS build

WORKDIR /restbase
RUN apk --no-cache add git python make g++
RUN git clone https://github.com/wikimedia/restbase.git .

RUN npm install

FROM node:alpine

COPY --from=build /restbase /restbase

COPY config.yaml /restbase/config.yaml
COPY droidwiki.yaml /restbase/projects/droidwiki.yaml
COPY droidwiki_sys.yaml /restbase/projects/sys/droidwiki.yaml
WORKDIR /restbase
ENV APP_BASE_PATH "/restbase"
EXPOSE 7231

CMD ["node", "/restbase/server.js"]
