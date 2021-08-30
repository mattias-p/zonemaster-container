FROM node:14 AS build

ARG ref=develop

RUN apt-get update \
 && apt-get upgrade -y \
 && rm -rf /var/lib/apt/lists/* \
 && git clone https://github.com/zonemaster/zonemaster-gui.git /app \
 && cd /app \
 && git checkout $ref \
 && npm i \
 && npm run build

FROM nginx:alpine

COPY --from=build /app/dist/ /usr/share/nginx/html/
COPY ./config/zonemaster.conf.template /etc/nginx/templates/zonemaster.conf.template

RUN rm /usr/share/nginx/html/assets/app.config.json \
 && rm /etc/nginx/conf.d/* \
 && ln -s /config/app.config.json /usr/share/nginx/html/assets/app.config.json

VOLUME /config
