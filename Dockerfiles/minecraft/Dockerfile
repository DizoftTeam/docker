# Базовый образ
FROM java:8-jre-alpine

# Разработчик
LABEL MAINTAINER="WiRight"

# Устанавливаем базовые зависимости
RUN apk update \
	&& apk add --no-cache \
		wget \
		screen

# Рабочая папка
WORKDIR /app

# Скачиваем сам сервер
RUN wget \
	--https-only \
	--no-directories \
	https://launcher.mojang.com/v1/objects/c5f6fb23c3876461d46ec380421e42b289789530/server.jar

# Соглашаемся с пользовательским соглашением, иначе не стартанет
RUN echo 'eula=true' >> /app/eula.txt \
	# Добавление пользователя AdminRdip в качестве администратора
	&& echo "AdminRdip" >> /app/ops.txt

# Копируем настройки сервера
COPY mine_1.16.2.server.properties /app/server.properties

# Расшариваем порт 25565
EXPOSE 25565

# Команда для запуска сервера
CMD ["java", "-Xmx1024M", "-Xms1024M", "-jar", "server.jar", "nogui"]
