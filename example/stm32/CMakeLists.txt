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
#SET(PLATFORM_TOOLCHAIN_PATH "/home/fx/.arduino15/./packages/arduino/tools/arm-none-eabi-gcc/4.8.3-2014q1/bin")
SET(PLATFORM_TOOLCHAIN_PATH "/opt/arm_gcc_2017/gcc-arm-none-eabi-7-2017-q4-major/bin/")

#  Path to the platform folder
# You can download it from https://github.com/rogerclarkmelbourne/Arduino_STM32.git 
# The last folder MUST BE arduino
#SET(PLATFORM_PATH "/opt/arduino-1.8.1/hardware/STM32/arduino")
# Roger Clark Melbourne version
SET(PLATFORM_PATH "/home/fx/Arduino/hardware/arduino/")
# Vanilla version
SET(PLATFORM_PATH "/home/fx/Arduino/hardware/vanillaSTM32/arduino")
# and here we go
SET(CMAKE_TOOLCHAIN_FILE cmake/ArduinoToolchain.cmake)
MESSAGE(STATUS "Starting hello-stm32")
#
#
#
Project("Hello_stm32" C CXX ASM) # ASM must be present !

print_board_list()

#
set(ARDUINO_DEFAULT_BOARD genericSTM32F103C) # Default Board ID, when not specified
set(ARDUINO_DEFAULT_PORT  ttyACM0) # Default Port, when not specified
set(ARDUINO_CPU           STM32F103C8)
#
#generate_arduino_firmware(hello 
                #SKETCH hello.ino              # Folder to get the .ino from, must follow DIR_NAME/DIR_NAME.ino patten !
                #PORT ${ARDUINO_DEFAULT_PORT}
                #BOARD_CPU ${ARDUINO_CPU}
                #)
#--------------------------------------------------------------------------------------
