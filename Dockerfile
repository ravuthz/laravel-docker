FROM php:7.0-apache

RUN docker-php-ext-install gd mysqli pdo pdo_mysql mcrypt
RUN docker-php-ext-install -j5 gd mbstring mysqli pdo pdo_mysql shmop
RUN a2enmod rewrite

COPY . /var/www
COPY ./public /var/www/html

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php -r "if (hash_file('SHA384', 'composer-setup.php') === '544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
RUN php composer-setup.php
RUN php -r "unlink('composer-setup.php');"

# RUN cp /var/www/.env.example /var/www/.env
# RUN php composer.phar install

# ADD config/docker/apache.conf /etc/apache2/httpd.conf
# COPY config/docker/php.ini /usr/local/etc/php/
