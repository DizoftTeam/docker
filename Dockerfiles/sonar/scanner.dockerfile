# Наследуемся от базового образа debian
FROM debian:9
# Разработчик образа
LABEL maintainer="WiRight"

# Установка зависимостей
RUN mkdir -p ~/Apps/sonarscanner \
	&& cd ~/Apps/sonarscanner \
	&& apt-get update \
	&& apt-get install -y \
		unzip \
		wget \
	&& wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-3.3.0.1492-linux.zip \
	&& unzip sonar-scanner-cli-3.3.0.1492-linux.zip \
	&& mv sonar-scanner-3.3.0.1492-linux/* ./ \
	&& rm sonar-scanner-cli-3.3.0.1492-linux.zip \
	&& rm -rf sonar-scanner-3.3.0.1492-linux \
	&& mkdir -p /var/www/sonar

# Обновляем PATH для доступа к sonar-scanner
ENV PATH="~/Apps/sonarscanner/bin:${PATH}"

# Рабочая папка
WORKDIR /var/www/sonar

# Команда, которая будет исполняться при запуске контейнера
CMD ["sonar-scanner"]
