FROM dizoft/php7.2-dev

# Установка Yarn
RUN apk update \
	&& apk add \
		--no-cache \
		--update \
		yarn
