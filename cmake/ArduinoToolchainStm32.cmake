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
list(APPEND CMAKE_SYSTEM_PREFIX_PATH "/opt/st32gcc/bin") # FIXME
SET(USER_INSTALL_FOLDER "/home/fx/.arduino15/packages/arduino") # FIXME
#
MACRO(STM32_ADD_SEARCH_PATH subfolder)
    list(APPEND CMAKE_SYSTEM_PREFIX_PATH ${ARDUINO_SDK_PATH}/hardware/${subfolder})
    list(APPEND CMAKE_SYSTEM_PREFIX_PATH ${USER_INSTALL_FOLDER}/${subfolder})
ENDMACRO(STM32_ADD_SEARCH_PATH subfolder)
#
SET(STM32_TOOLCHAIN_PREFIX arm-none-eabi-)
set(CMAKE_C_COMPILER   ${STM32_TOOLCHAIN_PREFIX}gcc)
set(CMAKE_ASM_COMPILER ${STM32_TOOLCHAIN_PREFIX}gcc)
set(CMAKE_CXX_COMPILER ${STM32_TOOLCHAIN_PREFIX}g++)

if (ARDUINO_SDK_PATH)
    set(ENV{_ARDUINO_CMAKE_WORKAROUND_ARDUINO_SDK_PATH} "${ARDUINO_SDK_PATH}")

    STM32_ADD_SEARCH_PATH(tools/arm-none-eabi-gcc)
    STM32_ADD_SEARCH_PATH(tools/openocd)
    STM32_ADD_SEARCH_PATH(tools/arduinoSTM32load)
else ()
    message(FATAL_ERROR "Could not find Arduino SDK (set ARDUINO_SDK_PATH)!")
endif ()
