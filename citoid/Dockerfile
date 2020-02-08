FROM node:alpine AS build

WORKDIR /source
RUN apk --no-cache add git python make g++
RUN git clone https://github.com/wikimedia/citoid.git .

RUN npm ci

FROM node:alpine

COPY --from=build /source /bin

WORKDIR /bin
EXPOSE 1970

CMD ["npm", "start"]
