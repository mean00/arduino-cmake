#_get_board_property(${BOARD_ID} speed_72mhz.build.f_cpu FCPU) # Sane default...
_get_board_property(${BOARD_ID} menu.cpu.speed_72mhz.build.f_cpu FCPU)
#
_try_get_board_property(${BOARD_ID} menu.cpu.${ARDUINO_CPU}.build.cpu_flags TRY_CPU_FLAGS)
IF(TRY_CPU_FLAGS)
    SET(CPU_FLAGS ${TRY_CPU_FLAGS})
ELSE(TRY_CPU_FLAGS)
    _get_board_property(${BOARD_ID} build.cpu_flags CPU_FLAGS)
ENDIF(TRY_CPU_FLAGS)

set(COMPILE_FLAGS "-DF_CPU=${FCPU} ${CPU_FLAGS} -DARDUINO=${NORMALIZED_SDK_VERSION} ")
# This should be derived from the arduino config files
# hardcode them for the moment


#
MACRO(DBG)
    MESSAGE(STATUS ${ARGN})
ENDMACRO(DBG)


MACRO(ADD_IF_DEFINED  key )
    DBG("Checking ${key}")
    if( DEFINED ${BOARD_ID}.${key})
        DBG("Yes ${key}: ${${BOARD_ID}.${key}}")
        #SET(COMPILE_FLAGS  "${COMPILE_FLAGS} ${${BOARD_ID}.${key}}")
    endif( DEFINED ${BOARD_ID}.${key})
ENDMACRO(ADD_IF_DEFINED  key)

MACRO(SET_IF_DEFINED  key out )
    DBG("Checking ${key}")
    if( DEFINED ${BOARD_ID}.${key})
        DBG("Yes  ${key}=>${${BOARD_ID}.${key}} ")
        #SET(${out}  "${${BOARD_ID}.${key}} ")
    endif( DEFINED ${BOARD_ID}.${key})
ENDMACRO(SET_IF_DEFINED  key out)


MACRO(ADD_TO_COMPILE_FLAGS key prefix)
   DBG("Checking ${key}")
    if( DEFINED ${BOARD_ID}.${key})
        DBG("Yes ${key} -D${prefix}${${BOARD_ID}.${key}} ")
        #SET(COMPILE_FLAGS "${COMPILE_FLAGS} -D${prefix}${${BOARD_ID}.${key}} ")
    endif( DEFINED ${BOARD_ID}.${key})
ENDMACRO(ADD_TO_COMPILE_FLAGS key prefix)
#
SET(STM32_SYSTEM_ROOT "-I\"${${BOARD_CORE}.path}/../../system/")
set(COMPILE_FLAGS "${COMPILE_FLAGS} ${STM32_SYSTEM_ROOT}/libmaple/\" ") # Hack, there is a better way to get the system path
set(COMPILE_FLAGS "${COMPILE_FLAGS} ${STM32_SYSTEM_ROOT}/libmaple/include\" ") # Hack, there is a better way to get the system path
set(COMPILE_FLAGS "${COMPILE_FLAGS} ${STM32_SYSTEM_ROOT}/libmaple/usb/usb_lib/\" ") # Hack, there is a better way to get the system path
set(COMPILE_FLAGS "${COMPILE_FLAGS} ${STM32_SYSTEM_ROOT}/libmaple/usb/stm32f1/\" ") # Hack, there is a better way to get the system path


# ZZ SET_IF_DEFINED(build.vect vec1)
# ZZ SET_IF_DEFINED(menu.cpu.${ARDUINO_UPLOAD_METHOD}Method.build.vect vec2)

IF(DEFINED vec2)
    # ZZ SET(COMPILE_FLAGS "${COMPILE_FLAGS} -D${vec2}")
ELSE(DEFINED vec2)
    # ZZ SET(COMPILE_FLAGS "${COMPILE_FLAGS} -D${vec1}")
ENDIF(DEFINED vec2)

# upload flags if any
#ZZ ADD_IF_DEFINED(menu.cpu.${ARDUINO_UPLOAD_METHOD}Method.build.upload_flags )
#ZZ ADD_IF_DEFINED(menu.cpu.${ARDUINO_CPU}.build.cpu_flags)

ADD_TO_COMPILE_FLAGS(build.error_led_port  "ERROR_LED_PORT=")
ADD_TO_COMPILE_FLAGS(build.error_led_pin  "ERROR_LED_PIN=")
ADD_TO_COMPILE_FLAGS(build.board  "ARDUINO_")
ADD_TO_COMPILE_FLAGS(build.variant  "BOARD_")


DBG("Compile flags = ${COMPILE_FLAGS}")
#
#set(COMPILE_FLAGS "${COMPILE_FLAGS} -std=gnu11 -MMD -DDEBUG_LEVEL=DEBUG_NONE ")


