#_get_board_property(${BOARD_ID} speed_72mhz.build.f_cpu FCPU) # Sane default...
#_get_board_property(${BOARD_ID} menu.cpu.speed_72mhz.build.f_cpu FCPU)
#
#_try_get_board_property(${BOARD_ID} menu.cpu.${ARDUINO_CPU}.build.cpu_flags TRY_CPU_FLAGS)
#IF(TRY_CPU_FLAGS)
    #SET(CPU_FLAGS ${TRY_CPU_FLAGS})
#ELSE(TRY_CPU_FLAGS)
    #_get_board_property(${BOARD_ID} build.cpu_flags CPU_FLAGS)
#ENDIF(TRY_CPU_FLAGS)

#set(COMPILE_FLAGS "-DF_CPU=${FCPU} ${CPU_FLAGS} -DARDUINO=${NORMALIZED_SDK_VERSION} ")
set(COMPILE_FLAGS " -DARDUINO=${NORMALIZED_SDK_VERSION} ")
# This should be derived from the arduino config files
# hardcode them for the moment


#
MACRO(DBG)
#    MESSAGE(STATUS ${ARGN})
ENDMACRO(DBG)


MACRO(ADD_IF_DEFINED  key )
    DBG("Checking ${key}")
    if( DEFINED ${BOARD_ID}.${key})
        DBG("Yes ${key}: ${${BOARD_ID}.${key}}")
        SET(COMPILE_FLAGS  "${COMPILE_FLAGS} ${${BOARD_ID}.${key}}")
    endif( DEFINED ${BOARD_ID}.${key})
ENDMACRO(ADD_IF_DEFINED  key)

MACRO(SET_IF_DEFINED  key out )
    DBG("Checking ${key}")
    if( DEFINED ${BOARD_ID}.${key})
        DBG("Yes  ${key}=>${${BOARD_ID}.${key}} ")
        SET(${out}  "${${BOARD_ID}.${key}} ")
    endif( DEFINED ${BOARD_ID}.${key})
ENDMACRO(SET_IF_DEFINED  key out)


MACRO(ADD_TO_COMPILE_FLAGS key prefix)
   DBG("Checking ${key}")
    if( DEFINED ${BOARD_ID}.${key})
        DBG("Yes ${key} -D${prefix}${${BOARD_ID}.${key}} ")
        SET(COMPILE_FLAGS "${COMPILE_FLAGS} -D${prefix}${${BOARD_ID}.${key}} ")
    endif( DEFINED ${BOARD_ID}.${key})
ENDMACRO(ADD_TO_COMPILE_FLAGS key prefix)
#
SET(ESP32_SYSTEM_ROOT "/home/fx/Arduino/hardware/espressif/esp32/")
#
#
MACRO(ADD_IPATH path)
    set(COMPILE_FLAGS "${COMPILE_FLAGS} ${ESP32_SYSTEM_ROOT}/tools/sdk/include/${path}\" ") # Hack, there is a better way to get the system path
ENDMACRO(ADD_IPATH path)
#
#
ADD_IPATH(config )
ADD_IPATH(app_trace )
ADD_IPATH(app_update )
ADD_IPATH(asio )
ADD_IPATH(bootloader_support )
ADD_IPATH(bt )
ADD_IPATH(coap )
ADD_IPATH(console )
ADD_IPATH(driver )
ADD_IPATH(esp-tls )
ADD_IPATH(esp32 )
ADD_IPATH(esp_adc_cal )
ADD_IPATH(esp_event )
ADD_IPATH(esp_http_client )
ADD_IPATH(esp_http_server )
ADD_IPATH(esp_https_ota )
ADD_IPATH(esp_ringbuf )
ADD_IPATH(ethernet )
ADD_IPATH(expat )
ADD_IPATH(fatfs )
ADD_IPATH(freemodbus )
ADD_IPATH(freertos )
ADD_IPATH(heap )
ADD_IPATH(idf_test )
ADD_IPATH(jsmn )
ADD_IPATH(json )
ADD_IPATH(libsodium )
ADD_IPATH(log )
ADD_IPATH(lwip )
ADD_IPATH(mbedtls )
ADD_IPATH(mdns )
ADD_IPATH(micro-ecc )
ADD_IPATH(mqtt )
ADD_IPATH(newlib )
ADD_IPATH(nghttp )
ADD_IPATH(nvs_flash )
ADD_IPATH(openssl )
ADD_IPATH(protobuf-c )
ADD_IPATH(protocomm )
ADD_IPATH(pthread )
ADD_IPATH(sdmmc )
ADD_IPATH(smartconfig_ack )
ADD_IPATH(soc )
ADD_IPATH(spi_flash )
ADD_IPATH(spiffs )
ADD_IPATH(tcp_transport )
ADD_IPATH(tcpip_adapter )
ADD_IPATH(ulp )
ADD_IPATH(vfs )
ADD_IPATH(wear_levelling )
ADD_IPATH(wifi_provisioning )
ADD_IPATH(wpa_supplicant )
ADD_IPATH(xtensa-debug-module )
ADD_IPATH(esp-face )
ADD_IPATH(esp32-camera )
ADD_IPATH(esp-face )

#ADD_TO_COMPILE_FLAGS(build.vect   "")
#ADD_TO_COMPILE_FLAGS(menu.cpu.${ARDUINO_UPLOAD_METHOD}Method.build.vect  "")

# upload flags if any
#ADD_IF_DEFINED(menu.cpu.${ARDUINO_UPLOAD_METHOD}Method.build.upload_flags )
#ADD_IF_DEFINED(menu.cpu.${ARDUINO_CPU}.build.cpu_flags )

#ADD_TO_COMPILE_FLAGS(build.error_led_port  "ERROR_LED_PORT=")
#ADD_TO_COMPILE_FLAGS(build.error_led_pin  "ERROR_LED_PIN=")
#ADD_TO_COMPILE_FLAGS(build.board  "ARDUINO_")
#ADD_TO_COMPILE_FLAGS(build.variant  "BOARD_")


DBG("Final Compile flags = ${COMPILE_FLAGS}")
#
#set(COMPILE_FLAGS "${COMPILE_FLAGS} -std=gnu11 -MMD -DDEBUG_LEVEL=DEBUG_NONE ")


