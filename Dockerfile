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

CMD ["php-fpm"]
