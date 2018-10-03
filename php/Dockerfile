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
    php -r "if (hash_file('SHA384', 'composer-setup.php') === '544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && \
    php composer-setup.php && \
    php -r "unlink('composer-setup.php');" && \
    mv composer.phar /usr/bin/composer;
