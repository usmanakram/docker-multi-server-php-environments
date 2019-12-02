FROM php:7.3-apache

#Install git
RUN apt-get update && apt-get upgrade -y
RUN docker-php-ext-install pdo pdo_mysql mysqli
RUN pecl install mongodb && docker-php-ext-enable mongodb
RUN echo "extension=mongodb.so" >> `php --ini | grep "Loaded Configuration" | sed -e "s|.*:\s*||"`
RUN a2enmod rewrite
#Install Composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php composer-setup.php --install-dir=. --filename=composer
RUN mv composer /usr/local/bin/
#COPY src/ /var/www/html/
EXPOSE 80