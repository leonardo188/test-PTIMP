# 1. Base image
FROM php:8.2-fpm

# 2. Install dependencies
RUN apt-get update && apt-get install -y \
    git curl zip unzip libpng-dev libonig-dev libxml2-dev \
    && docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# 3. Copy project files
WORKDIR /var/www
COPY . .

# 4. Install Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer
RUN composer install --no-interaction --no-scripts --no-autoloader
RUN composer dump-autoload

# 5. Set permissions
RUN chown -R www-data:www-data /var/www/storage /var/www/bootstrap/cache

# 6. Expose port
EXPOSE 8000

# 7. Run Laravel development server
CMD php artisan serve --host=0.0.0.0 --port=8000
