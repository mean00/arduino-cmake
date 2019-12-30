######################################
#
# Hello world for ESP32/Cmake
#
######################################
cmake_minimum_required(VERSION 3.0)
#--------------------------------------------------------------------------------------
# Select platform 
SET(PLATFORM_ARCHITECTURE "ESP32")
# and installation for extra arduino files AND toolchain (compiler...)
# Path to the toolchain, must contain arm-none-eabi-gcc,-g++ and friends
SET(PLATFORM_TOOLCHAIN_PATH "/home/fx/Arduino/hardware/espressif/esp32/tools/xtensa-esp32-elf/bin/")
#  Path to the platform folder
# You can download it from https://github.com/rogerclarkmelbourne/Arduino_STM32.git 
# ***** The last folder ** MUST BE *** arduino *****
SET(PLATFORM_PATH "/home/fx/Arduino/hardware/espressif/esp32")
# and here we go
SET(CMAKE_TOOLCHAIN_FILE cmake/ArduinoToolchain.cmake)
MESSAGE(STATUS "Starting Blink-esp32")
#
#
#
Project("Hello_esp32" C CXX ASM) # ASM must be present !
#MESSAGE(STATUS "Dumping board")
#print_board_list()
#
# that changes the way the binary is linked, better to use DFU in all cases !

#
set(ARDUINO_DEFAULT_BOARD esp32) 
set(ARDUINO_DEFAULT_PORT  ttyUSB0) 
SET(ESP32_USB_UPLOAD_SPEED 921600)
SET(ESP32_FLASH_SPEED      80m)
SET(ESP32_FLASH_MODE       dio)
SET(ESP32_FLASH_MODE_BOOTLOADER       qio)
SET(ESP32_FLASH_SIZE       4)

#set(ARDUINO_CPU           STM32F103C8)
#
generate_arduino_firmware(Blink2 
                SKETCH Blink.ino              
                PORT ${ARDUINO_DEFAULT_PORT}
                )
#--------------------------------------------------------------------------------------
