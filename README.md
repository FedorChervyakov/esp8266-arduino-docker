# Dockerized makeEspArduino

This project allows you to run [makeEspArduino](https://github.com/plerup/makeEspArduino) from docker container.
The docker image contains [makeEspArduino](https://github.com/plerup/makeEspArduino) and [esp8266/Arduino](https://github.com/esp8266/Arduino) repositories.

## Usage
### Building and running docker container
Run from host, replace <PROJECT_DIR> with absolute path to directory containing your source code:
```bash
docker run -it --rm \
    --device /dev/ttyUSB0:/dev/ttyUSB0 \
    -v <PROJECT_DIR>:/src \
    ghcr.io/fedorchervyakov/esp8266-arduino-docker:master
```

Or to flash a demo sketch and exit:
```bash
docker run --rm \
    --device /dev/ttyUSB0:/dev/ttyUSB0 \
    ghcr.io/fedorchervyakov/esp8266-arduino-docker:master \
    /bin/bash -c 'make -f ${MAKE_ESP_ARDUINO_BASE_DIR}/makeEspArduino.mk ESP_ROOT=${ARDUINO_ESP8266_BASE_DIR} DEMO=1 flash'
```

### Using makeEspArduino inside the container

#### Using Makefile
The recommended way to use this image is to provide a Makefile inside your project directory containing these two lines at the bottom:

```Makefile
ESP_ROOT = $(ARDUINO_ESP8266_BASE_DIR)
include $(MAKE_ESP_ARDUINO_BASE_DIR)/makeEspArduino.mk
```

Then you can simply run `make` from inside the container. For example to flash demo sketch:
```bash
make DEMO=1 flash
```

#### Using make's command line variables
For makeEspArduino to work, you have to pass paths to Makefile and esp8266/Arduino via command line arguments.
Environmental variables **MAKE_ESP_ARDUINO_BASE_DIR** and **ARDUINO_ESP8266_BASE_DIR** defined inside the container contain respective paths.
For example to flash demo sketch run this command inside the container:
```bash
make -f ${MAKE_ESP_ARDUINO_BASE_DIR}/makeEspArduino.mk ESP_ROOT=${ARDUINO_ESP8266_BASE_DIR} DEMO=1 flash
```
