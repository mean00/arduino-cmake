# -fno-rtti 
# -fno-exceptions
# -x c++
IF(NOT DEFINED ARDUINO_UPLOAD_METHOD)
    SET(ARDUINO_UPLOAD_METHOD "DFUUpload")
ENDIF(NOT DEFINED ARDUINO_UPLOAD_METHOD)

IF(NOT DEFINED ARDUINO_CFLAGS_SET)
    SET(DEFINED ARDUINO_CFLAGS_SET 1)
    SET(COMMON_FLAGS "-fstack-protector -ffunction-sections -fdata-sections -fstrict-volatile-bitfields -mlongcalls -nostdlib -Wpointer-arith  -Wno-maybe-uninitialized -Wno-unused-function -Wno-unused-but-set-variable -Wno-unused-variable -Wno-deprecated-declarations -Wno-unused-parameter -Wno-sign-compare -Wno-old-style-declaration") 
    SET(COMMON_FLAGS " ${COMMON_FLAGS}  -DF_CPU=240000000L -DARDUINO=10810 -DARDUINO_ESP32_DEV -DARDUINO_ARCH_ESP32 -DARDUINO_BOARD=\"ESP32_DEV\"" "-DARDUINO_VARIANT=\"esp32\"" -DESP32 -DCORE_DEBUG_LEVEL=0 )

    SET(ARDUINO_DEFAULT_CFLAGS " -std=gnu99 -Os -g3  ${COMMON_FLAGS}")
    SET(ARDUINO_DEFAULT_CXXFLAGS "-std=gnu++11 -Os -g3  -fexceptions  -fno-rtti " ${COMMON_FLAGS})

ENDIF(NOT DEFINED ARDUINO_CFLAGS_SET)
