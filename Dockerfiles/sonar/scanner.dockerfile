# TODO: стоит еще посмотреть на блок RUN:9 дабы оптимизировать
# Наследуемся от базового образа debian
FROM debian:9

# Разработчик образа
LABEL maintainer="WiRight"

# Установка зависимостей
RUN apt-get update \
	&& apt-get install -y \
		unzip \
		wget

# Установка sonar
RUN mkdir -p /usr/local/sonarscanner \
	&& cd /usr/local/sonarscanner \
	&& wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-3.3.0.1492-linux.zip \
	&& unzip sonar-scanner-cli-3.3.0.1492-linux.zip \
	&& mv sonar-scanner-3.3.0.1492-linux/* ./ \
	&& rm sonar-scanner-cli-3.3.0.1492-linux.zip \
	&& rm -rf sonar-scanner-3.3.0.1492-linux \
	&& ln -s /usr/local/sonarscanner/bin/sonar-scanner /usr/local/bin/sonar-scanner

# Создание рабочей папки
RUN mkdir -p /var/www/sonar

# Рабочая папка
WORKDIR /var/www/sonar

# Команда, которая будет исполняться при запуске контейнера
CMD ["sonar-scanner"]
