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
	https://launcher.mojang.com/v1/objects/3dc3d84a581f14691199cf6831b71ed1296a9fdf/server.jar

# Соглашаемся с пользовательским соглашением, иначе не стартанет
RUN echo 'eula=true' >> /app/eula.txt

# Копируем настройки сервера
COPY mine_1.14.4.server.properties /app/server.properties

# Расшариваем порт 25565
EXPOSE 25565

# Команда для запуска сервера
CMD ["java", "-Xmx1024M", "-Xms1024M", "-jar", "server.jar", "nogui"]
