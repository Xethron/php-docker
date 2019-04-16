FROM php:fpm

MAINTAINER Bernhard Breytenbach <docker@coffeecode.co.za>

RUN apt-get update && apt-get upgrade -y \
    && apt-get autoclean \
    && apt-get clean \
    && apt-get autoremove;

RUN usermod -u 1000 www-data
RUN groupmod -g 1000 www-data

COPY config/php.ini /usr/local/etc/php/

RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng-dev \
        libgmp-dev \
        re2c \
        libmhash-dev \
        git \
        zlib1g-dev libicu-dev g++ \
    && apt-get autoclean \
    && apt-get clean \
    && apt-get autoremove;

RUN ln -s /usr/include/x86_64-linux-gnu/gmp.h /usr/local/include/

RUN docker-php-ext-install -j$(nproc) iconv pdo_mysql mysqli bcmath zip pcntl intl \
 && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
 && docker-php-ext-install -j$(nproc) gd \
 && docker-php-ext-configure gmp \
 && docker-php-ext-install gmp

## Install Composer ##
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php -r "if (hash_file('SHA384', 'composer-setup.php') === '93b54496392c062774670ac18b134c3b3a95e5a5e5c8f1a9f115f203b75bf9a129d5daa8ba6a13e2cc8a1da0806388a8') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && \
    php composer-setup.php && \
    php -r "unlink('composer-setup.php');" && \
    mv composer.phar /usr/bin/composer;
