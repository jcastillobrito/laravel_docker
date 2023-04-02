FROM php:8.1-fpm

RUN apt-get update && apt-get install -y \
    git \
    zip \
    unzip 

RUN docker-php-ext-install pdo_mysql 

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer


ENV PATH="/var/www/html/vendor/bin:${PATH}"

WORKDIR /var/www/html

COPY ./src .

RUN composer install --no-dev --optimize-autoloader


RUN chown -R www-data:www-data storage/ bootstrap/cache &&   chmod -R 777 storage/ /var/www/html/bootstrap/cache

RUN php artisan key:generate

CMD ["php-fpm"]

EXPOSE 9000
