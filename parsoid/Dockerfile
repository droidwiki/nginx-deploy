ARG NODE_VERSION=13.13.0
FROM node:${NODE_VERSION}-alpine AS build

WORKDIR /source
RUN apk --no-cache add git python make g++
RUN git clone https://github.com/wikimedia/parsoid.git .

RUN npm install

FROM node:${NODE_VERSION}-alpine

COPY --from=build /source /bin

COPY config.yml /bin/config.yaml
WORKDIR /bin
EXPOSE 8142

CMD ["npm", "start"]
