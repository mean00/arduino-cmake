#_get_board_property(${BOARD_ID} speed_72mhz.build.f_cpu FCPU) # Sane default...
SET(FPCU "72000000L")
#    _get_board_property(${BOARD_ID} build.mcu MCU)
set(COMPILE_FLAGS "-DF_CPU=${FCPU} -DARDUINO=${NORMALIZED_SDK_VERSION} ")

