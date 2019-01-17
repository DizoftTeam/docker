# Наследуемся от базового образа dizoft/PHP7.1
FROM dizoft/php7.1-dev
# Имя разработчика образа
LABEL maintainer="WiRight"

# Установка xdebug
RUN pecl install xdebug \
	&& docker-php-ext-enable xdebug