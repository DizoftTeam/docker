# Наследуемся от базового образа PHP
FROM php:7.2.16-fpm-alpine

# Имя разработчика образа
LABEL MAINTAINER="WiRight"

# Переменная для установки временной зоны
ENV TZ=Europe/Moscow

# Установка базовых необходимых зависимостей
RUN apk update \
	&& apk add \
		--no-cache \
		--update \
		--virtual \
		buildDeps \
		gcc \
		g++ \
		make \
		build-base \
		wget \
		git \
		autoconf \
		tzdata \
	&& apk add --no-cache \
		bash \
		autoconf \
		postgresql-dev \
		openssl-dev \
		libmemcached-dev \
		rabbitmq-c-dev \
		libssh2 \
		zlib-dev \
		curl \
		git \
		unzip \
		freetype-dev \
		libjpeg-turbo-dev \
		libxslt-dev \
		icu-dev \
		libxml2-dev \
		libpng-dev \
	&& pecl install \
		memcached \
		mongodb \
		amqp \
	&& docker-php-ext-install \
		-j$(nproc) \
		iconv \
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
		gd

# Конфигурирование некоторых расширений
RUN docker-php-ext-configure intl \
	&& docker-php-ext-configure gd \
		--enable-gd-native-ttf \
		--with-jpeg-dir=/usr/include/ \
		--with-freetype-dir=/usr/include/freetype2 \
	&& docker-php-ext-enable memcached \
	&& docker-php-ext-enable mongodb \
	&& docker-php-ext-enable amqp

# Установка xdebug
RUN pecl install xdebug \
	&& docker-php-ext-enable xdebug

# Установка временной зоны
RUN cp /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Чистим некоторые не нужные зависимости
RUN apk del buildDeps \
	&& rm -rf /var/cache/apk/*

# Установка composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/ --filename=composer

# Конфиг php
ADD php.ini /usr/local/etc/php/conf.d/40-custom.ini

# Установка рабочей папки
WORKDIR /var/www/html

# Команда контейнера
CMD ["php-fpm"]
