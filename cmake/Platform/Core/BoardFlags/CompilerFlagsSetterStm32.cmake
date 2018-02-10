#_get_board_property(${BOARD_ID} speed_72mhz.build.f_cpu FCPU) # Sane default...
SET(FCPU "72000000L") # Hack
#    _get_board_property(${BOARD_ID} build.mcu MCU)
set(COMPILE_FLAGS "-DF_CPU=${FCPU} -DARDUINO=${NORMALIZED_SDK_VERSION} ")
set(COMPILE_FLAGS "${COMPILE_FLAGS} -I\"${${BOARD_CORE}.path}/../../system/libmaple/include\" ") # Hack, there is a better way to get the system path
set(COMPILE_FLAGS "${COMPILE_FLAGS} -I\"${${BOARD_CORE}.path}/../../system/libmaple/\" ") # Hack, there is a better way to get the system path

