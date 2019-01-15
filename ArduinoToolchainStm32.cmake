#=============================================================================#
# Author: Tomasz Bogdal (QueezyTheGreat)
# Home:   https://github.com/queezythegreat/arduino-cmake
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this file,
# You can obtain one at http://mozilla.org/MPL/2.0/.
#=============================================================================#
MESSAGE(STATUS "Setting up STM32 arduino cmake environment")
#
IF(NOT PLATFORM_TOOLCHAIN_PATH)
        MESSAGE(FATAL_ERROR "PLATFORM_TOOLCHAIN_PATH is not defined !")
ENDIF(NOT PLATFORM_TOOLCHAIN_PATH)
#


LIST(APPEND CMAKE_SYSTEM_PREFIX_PATH "${PLATFORM_TOOLCHAIN_PATH}")
SET(STM32_TOOLCHAIN_PREFIX arm-none-eabi-)

FUNCTION(FATAL_BANNER msg)
    MESSAGE(STATUS "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")
    MESSAGE(STATUS "${msg}")
    MESSAGE(STATUS "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")
    MESSAGE(FATAL_ERROR "${msg}")
ENDFUNCTION(FATAL_BANNER msg)

#
# Sanity check
#
IF(NOT EXISTS "${PLATFORM_TOOLCHAIN_PATH}/${STM32_TOOLCHAIN_PREFIX}gcc")
   FATAL_BANNER( "!! PLATFORM_TOOLCHAIN_PATH does not point to a valid toolchain (arm-none-eabi-gcc....)!! (${PLATFORM_TOOLCHAIN_PATH})")
ENDIF()
#
IF(EXISTS "${PLATFORM_PATH}/STM32F1")
    MESSAGE(STATUS "Looks like RogerClark flavor...")
    SET(STM32_FLAVOR "RGCLARCK" CACHE INTERNAL "")
ELSEIF ( EXISTS "${PLATFORM_PATH}/system/STM32F1xx")
    MESSAGE(STATUS "Looks like vanilla stm32duino")
    SET(STM32_FLAVOR "VANILLA" CACHE INTERNAL "")
ELSE()
   FATAL_BANNER( "!! PLATFORM_PATH does not point to valid STM32 arduino files!! (${PLATFORM_PATH})")
ENDIF()
#
SET(CMAKE_C_COMPILER_ID   "GNU" CACHE INTERNAL "")
SET(CMAKE_CXX_COMPILER_ID "GNU" CACHE INTERNAL "")
#
set(CMAKE_C_COMPILER   ${PLATFORM_TOOLCHAIN_PATH}/${STM32_TOOLCHAIN_PREFIX}gcc CACHE PATH "" FORCE)
set(CMAKE_ASM_COMPILER ${PLATFORM_TOOLCHAIN_PATH}/${STM32_TOOLCHAIN_PREFIX}gcc CACHE PATH "" FORCE)
set(CMAKE_CXX_COMPILER ${PLATFORM_TOOLCHAIN_PATH}/${STM32_TOOLCHAIN_PREFIX}g++ CACHE PATH "" FORCE)
 #set(CMAKE_CXX_LINK_EXECUTABLE    "<CMAKE_CXX_COMPILER>  <FLAGS> <CMAKE_CXX_LINK_FLAGS>  <LINK_FLAGS> <OBJECTS>  -o <TARGET> <LINK_LIBRARIES>")
# There is probably a cleaner way to do this....
 set(CMAKE_CXX_LINK_EXECUTABLE    "<CMAKE_CXX_COMPILER>   <CMAKE_CXX_LINK_FLAGS>  <LINK_FLAGS> -lgcc -mthumb -Wl,--start-group  <OBJECTS> <LINK_LIBRARIES> -Wl,--end-group   -o <TARGET> ")
#set(CMAKE_EXE_LINKER_FLAGS "" CACHE INTERNAL "")
#set(CMAKE_CXX_LINK_FLAGS   "" CACHE INTERNAL "")
#set(CMAKE_C_LINK_FLAGS     "" CACHE INTERNAL "")
#set(CMAKE_CXX_LINK_EXECUTABLE "echo CXXFLAGS: ${CMAKE_CXX_FLAGS} LINK_FLAGS: <LINK_FLAGS> LINK_LIBRARIES: <LINK_LIBRARIES> OBJECTS: <OBJECTS>")

MESSAGE(STATUS "C   compiler ${CMAKE_C_COMPILER}")
MESSAGE(STATUS "C++ compiler ${CMAKE_CXX_COMPILER}")

if (ARDUINO_SDK_PATH)
    set(ENV{_ARDUINO_CMAKE_WORKAROUND_ARDUINO_SDK_PATH} "${ARDUINO_SDK_PATH}")
else ()
    message(FATAL_ERROR "Could not find Arduino SDK (set ARDUINO_SDK_PATH)!")
endif ()

