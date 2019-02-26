# Наследуемся от базового образа PHP
FROM php:7.1-fpm
# Имя разработчика образа
LABEL maintainer="WiRight"

# Установка базовых зависимостей
RUN apt-get update \
	&& apt-get install -y \
		libpq-dev \
		libssl-dev \
		libmemcached-dev \
		zlib1g-dev \
		curl \
		git \
		unzip \
		libfreetype6-dev \
		libjpeg62-turbo-dev \
		libxslt-dev \
		libicu-dev \
		libmcrypt-dev \
		libxml2-dev \
	&& docker-php-ext-install \
		-j$(nproc) \
		iconv \
		mcrypt \
		mbstring \
		mysqli \
		pdo_mysql \
		zip \
		xsl \
		pdo_pgsql \
		soap \
		sockets \
		pdo \
		json \
		bcmath \
		gd \
	&& pecl install \
		memcached \
		mongodb

# Конфигурирование некоторых расширений
RUN docker-php-ext-configure intl \
	&& docker-php-ext-configure gd \
		--enable-gd-native-ttf \
		--with-jpeg-dir=/usr/include/ \
		--with-freetype-dir=/usr/include/freetype2 \
	&& docker-php-ext-enable memcached \
	&& docker-php-ext-enable mongodb

# Установка xdebug
RUN pecl install xdebug \
	&& docker-php-ext-enable xdebug

# Удаление не нужных зависимостей
RUN apt-get purge -y \
	libssl-dev

# Установка composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Конфиг php
ADD php.ini /usr/local/etc/php/conf.d/40-custom.ini

# Установка рабочей папки
WORKDIR /var/www/html

# Команда контейнера
CMD ["php-fpm"]
