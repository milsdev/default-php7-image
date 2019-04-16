FROM php:7-fpm
# Install modules

COPY php-fpm.conf /usr/local/etc/php-fpm.conf
RUN mkdir /var/log/php-fpm/

RUN apt-get update && apt-get install -y \
	libmcrypt-dev  \
	libicu-dev \
	libpng-dev \
	mysql-client \
	&& docker-php-ext-install pdo_mysql \
	&& docker-php-ext-install iconv \
	&& docker-php-ext-install mcrypt \
	&& docker-php-ext-install gd \
	&& docker-php-ext-install intl \
	&& docker-php-ext-install opcache \
	&& docker-php-ext-install mbstring \
	&& docker-php-ext-install mysqli

RUN apt-get update \
        && apt-get -y install \
                libmagickwand-dev \
            --no-install-recommends \
        && pecl install imagick \
        && docker-php-ext-enable imagick \
        && rm -r /var/lib/apt/lists/*

RUN pecl install xdebug \
    && docker-php-ext-enable xdebug \
    && echo "xdebug.remote_enable=1" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.remote_host=docker.for.mac.localhost" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.remote_port=9001" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.idekey=PHPSTORM" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.remote_log=/var/log/xdebug.log" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

CMD ["php-fpm"]
