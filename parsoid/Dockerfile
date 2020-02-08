FROM node:alpine AS build

WORKDIR /source
RUN apk --no-cache add git python make g++
RUN git clone https://github.com/wikimedia/parsoid.git .

RUN npm install

FROM node:alpine

COPY --from=build /source /bin

WORKDIR /bin
EXPOSE 8142

CMD ["npm", "start"]
