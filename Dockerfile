from ubuntu:20.04

ENV ARDUINO_ESP8266_VERSION 3.1.2
ENV ARDUINO_ESP8266_BASE_DIR /utils/esp8266
ENV MAKE_ESP_ARDUINO_BASE_DIR /utils/makeEspArduino

# create unprivileged user
RUN adduser --disabled-password --gecos '' myuser

# install deps
RUN apt-get update && apt-get upgrade -yy
RUN apt-get install -yy build-essential git python3.8

RUN ln -s /usr/bin/python3.8 /usr/bin/python3

RUN mkdir /utils

# install esp8266/Arduino
RUN git clone https://github.com/esp8266/Arduino.git ${ARDUINO_ESP8266_BASE_DIR} \
    && cd ${ARDUINO_ESP8266_BASE_DIR} \
    && git checkout tags/${ARDUINO_ESP8266_VERSION} \
    && git submodule update --init --recursive \
    && cd tools \
    && python3 get.py

# install plerup/makeEspArduino
RUN git clone https://github.com/plerup/makeEspArduino.git ${MAKE_ESP_ARDUINO_BASE_DIR}
