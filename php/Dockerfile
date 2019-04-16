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
        libzip-dev \
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
    php -r "if (hash_file('sha384', 'composer-setup.php') === '48e3236262b34d30969dca3c37281b3b4bbe3221bda826ac6a9a62d6444cdb0dcd0615698a5cbe587c3f0fe57a54d8f5') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && \
    php composer-setup.php && \
    php -r "unlink('composer-setup.php');" && \
    mv composer.phar /usr/bin/composer;
