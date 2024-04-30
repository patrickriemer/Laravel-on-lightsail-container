#!/bin/sh

set -- php-fpm "$@"

cd /var/www/html
php artisan migrate --force
php artisan db:seed --force

exec "$@"
