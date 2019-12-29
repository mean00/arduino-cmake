######################################
#
# Hello world for STM32/Cmake
#
######################################
cmake_minimum_required(VERSION 3.0)
#--------------------------------------------------------------------------------------
# Select platform 
SET(PLATFORM_ARCHITECTURE "STM32F1")
# and installation for extra arduino files AND toolchain (compiler...)
# Path to the toolchain, must contain arm-none-eabi-gcc,-g++ and friends
SET(PLATFORM_TOOLCHAIN_PATH "/home/fx/Arduino_stm32/arm-none-eabi-gcc/download/gcc-arm-none-eabi-8.2.1-1.7/bin")
#  Path to the platform folder
# You can download it from https://github.com/rogerclarkmelbourne/Arduino_STM32.git 
# Go the STM32F1 path
SET(PLATFORM_PATH "/home/fx/Arduino/hardware/stm32/STM32F1")
# and here we go
SET(CMAKE_TOOLCHAIN_FILE cmake/ArduinoToolchain.cmake)
MESSAGE(STATUS "Starting hello-stm32")
#
#
#
Project("Hello_stm32" C CXX ASM) # ASM must be present !

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
