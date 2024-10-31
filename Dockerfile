# Dockerfile необходим для сборки проекта без использования виртуальной машины
# ВНИМАНИЕ! Данный Dockerfile необходимо редактировать под каждый проект (за счет особенностей и используемых зависимостей)

# Выбираем образ (если собираете на домашнем ПК или стенде, то необходимо выкачать образы Астры из их регистра. Подробнее тут: https://wiki.astralinux.ru/pages/viewpage.action?pageId=257473207#:~:text=0%3A0%3A0)-,%D0%97%D0%B0%D0%B3%D1%80%D1%83%D0%B7%D0%BA%D0%B0%20%D0%B8%D1%81%D1%85%D0%BE%D0%B4%D0%BD%D0%BE%D0%B3%D0%BE%20%D0%BE%D0%B1%D1%80%D0%B0%D0%B7%D0%B0,-%D0%94%D0%B0%D0%BB%D0%B5%D0%B5%20%D0%BF%D1%80%D0%B5%D0%B4%D0%BF%D0%BE%D0%BB%D0%B0%D0%B3%D0%B0%D0%B5%D1%82%D1%81%D1%8F%2C%20%D1%87%D1%82%D0%BE)
FROM registry.astralinux.ru/library/alse:1.7.4
# Обновление и установка необходимых пакетов
RUN apt update && apt install -y redis curl xz-utils
# Выкачиваем Nodejs из оф.сайта и проводим установку
RUN cd /tmp
RUN curl -O https://nodejs.org/dist/v12.22.12/node-v12.22.12-linux-x64.tar.xz

RUN mkdir -p /usr/local/lib/nodejs
RUN mkdir -p /tmp/node-install
RUN cd /tmp/node-install
RUN cd /tmp
RUN tar -xJvf node-v12.22.12-linux-x64.tar.xz -C /usr/local/lib/nodejs
RUN export PATH=/usr/local/lib/nodejs/node-v12.22.12-linux-x64/bin:$PATH

RUN ln -s /usr/local/lib/nodejs/node-v12.22.12-linux-x64/bin/node /usr/bin/node
RUN ln -s /usr/local/lib/nodejs/node-v12.22.12-linux-x64/bin/npm /usr/bin/npm
RUN ln -s /usr/local/lib/nodejs/node-v12.22.12-linux-x64/bin/npx /usr/bin/npx

# В entrypoing запускаем главный сервис
ENTRYPOINT /usr/bin/redis-server