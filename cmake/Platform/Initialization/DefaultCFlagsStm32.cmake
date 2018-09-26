# -fno-rtti 
# -fno-exceptions
# -x c++
SET(ARDUINO_DEFAULT_CFLAGS " -ffunction-sections -fdata-sections -nostdlib --param max-inline-insns-single=500  -w   -mcpu=cortex-m3  -mthumb  -fno-rtti  -fno-exceptions  -g ")
SET(ARDUINO_DEFAULT_CFLAGS " ${ARDUINO_DEFAULT_CFLAGS} -DVECT_TAB_ADDR=0x8002000  -DF_CPU=72000000L -DARDUINO=10801  -DARDUINO_ARCH_STM32F1  -DSERIAL_USB -DGENERIC_BOOTLOADER -DMCU_STM32F103R8 -DCONFIG_MAPLE_MINI_NO_DISABLE_DEBUG    ")
