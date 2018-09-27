# -fno-rtti 
# -fno-exceptions
# -x c++
SET(ARDUINO_DEFAULT_CFLAGS " -ffunction-sections -fdata-sections -nostdlib --param max-inline-insns-single=500  -w   -mcpu=cortex-m3  -mthumb  -fno-rtti  -fno-exceptions  -g ")
SET(ARDUINO_DEFAULT_CFLAGS " ${ARDUINO_DEFAULT_CFLAGS}  -DF_CPU=72000000L  -DARDUINO_ARCH_STM32F1 -DCONFIG_MAPLE_MINI_NO_DISABLE_DEBUG    ")
