# Per board cflags
_get_board_property(${BOARD_ID} build.f_cpu FCPU)
_get_board_property(${BOARD_ID} build.mcu MCU)
_get_board_property(${BOARD_ID} build.board BOARD)


set(COMPILE_FLAGS "-DF_CPU=${FCPU} -DARDUINO=${NORMALIZED_SDK_VERSION} -mmcu=${MCU} -DARDUINO_ARCH_AVR -DARDUINO_${BOARD}")

