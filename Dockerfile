# استخدم PHP 8.3 CLI
FROM php:8.3-cli

# تثبيت الأدوات المطلوبة
RUN apt-get update && apt-get install -y \
    unzip \
    git \
    curl \
    libsqlite3-dev \
    libzip-dev \
    && docker-php-ext-install pdo_sqlite zip

# Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# مجلد العمل
WORKDIR /app

# انسخ المشروع كله
COPY . .

# تثبيت الحزم
RUN composer install --no-dev --optimize-autoloader

# إنشاء ملف SQLite إذا المشروع يحتاجه
# SQLite موجود مسبقًا في المشروع

# exposed port Railway
EXPOSE 8080

# CMD يستخدم PORT من Railway
CMD php artisan serve --host=0.0.0.0 --port=$PORT