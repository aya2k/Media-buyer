FROM php:8.3-cli

RUN apt-get update && apt-get install -y \
    unzip \
    git \
    curl \
    libsqlite3-dev

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /app

COPY . .

RUN composer install --no-dev --optimize-autoloader

RUN touch database/database.sqlite

ENV DB_CONNECTION=sqlite

RUN php artisan key:generate
RUN php artisan config:cache
RUN php artisan route:cache
RUN php artisan view:cache

EXPOSE 10000

CMD php artisan serve --host=0.0.0.0 --port=10000