FROM node:8-alpine
MAINTAINER dan.turner@cba.com.au

ENV APP_DIR /home/node/app

# Copy application source to $APP_DIR.
WORKDIR $APP_DIR

RUN apk add --update --no-cache --virtual .build-deps git \
		&& git clone https://github.com/cubedro/eth-netstats . \
    && npm install --force \
    && cd node_modules/geoip-lite \
		&& npm run-script updatedb \
    && npm cache clean --force  \
    && apk del .build-deps

# Set default docker user to node (provided by base image).
USER node

EXPOSE 3000
CMD [ "npm", "start" ]