ARG NODE_VERSION=14.3.0
FROM node:${NODE_VERSION}-alpine AS build

WORKDIR /source
RUN apk --no-cache add git python make g++
RUN git clone https://github.com/wikimedia/citoid.git .

# Use npm ci after https://phabricator.wikimedia.org/T247108 is resolved
RUN npm install

FROM node:${NODE_VERSION}-alpine

COPY --from=build /source /bin

COPY config.yml /bin/config.yml
WORKDIR /bin
EXPOSE 1970

CMD ["npm", "start"]
