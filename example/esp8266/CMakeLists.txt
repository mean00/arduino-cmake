######################################
#
# Hello world for esp8266/Cmake
#
######################################
cmake_minimum_required(VERSION 3.0)
#--------------------------------------------------------------------------------------
# Select platform 
SET(PLATFORM_ARCHITECTURE "ESP8266")
# and installation for extra arduino files AND toolchain (compiler...)
# Path to the toolchain, must contain arm-none-eabi-gcc,-g++ and friends
SET(PLATFORM_TOOLCHAIN_PATH "/home/fx/.arduino15/packages/esp8266/tools/xtensa-lx106-elf-gcc/2.5.0-3-20ed2b9/bin/")
#  Path to the platform folder
# You can download it from https://github.com/rogerclarkmelbourne/Arduino_STM32.git 
# The last folder MUST BE arduino
SET(PLATFORM_PATH "/home/fx/.arduino15/packages/esp8266/hardware/esp8266/arduino/")
# and here we go
SET(CMAKE_TOOLCHAIN_FILE cmake/ArduinoToolchain.cmake)
MESSAGE(STATUS "Starting hello-esp8266")
#
#
#
Project("Hello_esp8266" C CXX ASM) # ASM must be present !

print_board_list()
# Possible choice for STM32
#  BMP    : BlackMagic
#  STLink : ST link v2
#  DFUUpload: Arduino 
#
# that changes the way the binary is linked, better to use DFU in all cases !
SET(ARDUINO_UPLOAD_METHOD DFUUpload)

#
set(ARDUINO_DEFAULT_BOARD genericSTM32F103C) # Default Board ID, when not specified
set(ARDUINO_DEFAULT_PORT  ttyACM0) # Default Port, when not specified
set(ARDUINO_CPU           STM32F103C8)
#
generate_arduino_firmware(hello 
                SKETCH hello.ino              # Folder to get the .ino from, must follow DIR_NAME/DIR_NAME.ino patten !
                PORT ${ARDUINO_DEFAULT_PORT}
                )
#--------------------------------------------------------------------------------------
