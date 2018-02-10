#_get_board_property(${BOARD_ID} speed_72mhz.build.f_cpu FCPU) # Sane default...
SET(FCPU "72000000L") # Hack
#    _get_board_property(${BOARD_ID} build.mcu MCU)
set(COMPILE_FLAGS "-DF_CPU=${FCPU} -DARDUINO=${NORMALIZED_SDK_VERSION} ")
# This should be derived from the arduino config files
# hardcode them for the moment
SET(STM32_SYSTEM_ROOT "-I\"${${BOARD_CORE}.path}/../../system/")
set(COMPILE_FLAGS "${COMPILE_FLAGS} ${STM32_SYSTEM_ROOT}/libmaple/include\" ") # Hack, there is a better way to get the system path
set(COMPILE_FLAGS "${COMPILE_FLAGS} ${STM32_SYSTEM_ROOT}/libmaple/include/libmaple\" ") # Hack, there is a better way to get the system path
set(COMPILE_FLAGS "${COMPILE_FLAGS} ${STM32_SYSTEM_ROOT}/libmaple/\" ") # Hack, there is a better way to get the system path
set(COMPILE_FLAGS "${COMPILE_FLAGS} ${STM32_SYSTEM_ROOT}/libmaple/usb/usb_lib/\" ") # Hack, there is a better way to get the system path
set(COMPILE_FLAGS "${COMPILE_FLAGS} ${STM32_SYSTEM_ROOT}/libmaple/usb/stm32f1/\" ") # Hack, there is a better way to get the system path

#
#set(COMPILE_FLAGS "${COMPILE_FLAGS} -std=gnu11 -MMD -DDEBUG_LEVEL=DEBUG_NONE ")


