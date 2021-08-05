FROM node:14 AS build

# Allow customization
RUN git clone https://github.com/blacksponge/zonemaster-gui.git /app && \
    cd /app && \
    git checkout add-runtime-config && \
    npm i && \
    npm run build

FROM nginx

VOLUME /config

COPY --from=build /app/dist/ /usr/share/nginx/html/
COPY ./config/zonemaster.conf.template /etc/nginx/templates/zonemaster.conf.template

RUN rm /usr/share/nginx/html/assets/app.config.json && \
    rm /etc/nginx/conf.d/* && \
    ln -s /config/app.config.json /usr/share/nginx/html/assets/app.config.json
