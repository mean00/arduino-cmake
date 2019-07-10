# -fno-rtti 
# -fno-exceptions
# -x c++
IF(NOT DEFINED ARDUINO_UPLOAD_METHOD)
    SET(ARDUINO_UPLOAD_METHOD "DFUUpload")
ENDIF(NOT DEFINED ARDUINO_UPLOAD_METHOD)


SET(ARDUINO_DEFAULT_CFLAGS " -ffunction-sections -fdata-sections -nostdlib --param max-inline-insns-single=500  -w   -mcpu=cortex-m3  -mthumb   -g ")
SET(ARDUINO_DEFAULT_CFLAGS " ${ARDUINO_DEFAULT_CFLAGS}  -DF_CPU=72000000L  -DARDUINO_ARCH_STM32F1 -DCONFIG_MAPLE_MINI_NO_DISABLE_DEBUG    ")
#SET(ARDUINO_DEFAULT_CFLAGS " ${ARDUINO_DEFAULT_CFLAGS}  -DF_CPU=72000000L  -DARDUINO_ARCH_STM32F1 ")

SET(ARDUINO_DEFAULT_CXXFLAGS "${ARDUINO_DEFAULT_CFLAGS} -fno-rtti  -fno-exceptions -std=gnu++11")
SET(ARDUINO_DEFAULT_CFLAGS "${ARDUINO_DEFAULT_CFLAGS} -std=gnu11")
IF(ARDUINO_USE_NEWLIB) # smaller
    SET(ARDUINO_DEFAULT_CFLAGS " ${ARDUINO_DEFAULT_CFLAGS} --specs=nano.specs") 
ENDIF(ARDUINO_USE_NEWLIB) # smaller
