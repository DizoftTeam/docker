# Базовый образ
FROM java:8-jre-alpine

# Разработчик
LABEL MAINTAINER="WiRight"

# Устанавливаем базовые зависимости
RUN apk update \
	&& apk add --no-cache \
		wget

# Рабочая папка
WORKDIR /app

# Скачиваем сам сервер
RUN wget \
	--https-only \
	--no-directories \
	https://launcher.mojang.com/v1/objects/3737db93722a9e39eeada7c27e7aca28b144ffa7/server.jar

# Соглашаемся с пользовательским соглашением, иначе не стартанет
RUN echo 'eula=true' >> /app/eula.txt

# Копируем настройки сервера
COPY server.properties /app/

# Расшариваем порт 25565
EXPOSE 25565

# Команда для запуска сервера
CMD ["java", "-Xmx1024M", "-Xms1024M", "-jar", "server.jar", "nogui"]
