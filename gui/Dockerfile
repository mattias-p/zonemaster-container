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
COPY ./config/nginx.conf /etc/nginx/nginx.conf

RUN rm /usr/share/nginx/html/assets/app.config.json && \
    ln -s /config/app.config.json /usr/share/nginx/html/assets/app.config.json
