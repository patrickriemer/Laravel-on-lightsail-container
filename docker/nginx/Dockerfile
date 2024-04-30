FROM nginx:alpine

ADD docker/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf

WORKDIR /var/www/html
COPY --chown=www-data:www-data . .
