
# Select platform and installation for extra arduino files AND toolchain (compiler...)
SET(PLATFORM_ARCHITECTURE "STM32F1")
# Must be named arduino
#  else the cmake code will look for ARDUINO
# while the name will be the name of the folder
SET(PLATFORM_PATH "/opt/arduino-1.8.5/hardware/STM32/arduino")
#SET(PLATFORM_TOOLCHAIN_PATH "/home/fx/.arduino15/./packages/arduino/tools/arm-none-eabi-gcc/4.8.3-2014q1/bin")
SET(PLATFORM_TOOLCHAIN_PATH "/home/fx/.arduino15/packages/STM32/tools/arm-none-eabi-gcc/6-2017-q2-update/bin")
# and here we go
SET(CMAKE_TOOLCHAIN_FILE cmake/ArduinoToolchain.cmake)
MESSAGE(STATUS "Starting hello-stm32")

cmake_minimum_required(VERSION 2.8)
Project("Hello_stm32" C CXX ASM)

print_board_list()


set(ARDUINO_DEFAULT_BOARD genericSTM32F103C) # Default Board ID, when not specified
set(ARDUINO_DEFAULT_PORT /dev/ttyACM0) # Default Port, when not specified
set(ARDUINO_CPU          STM32F103C8)

generate_arduino_firmware(hello 
                SKETCH hello.ino              # Folder to get the .ino from, must follow DIR_NAME/DIR_NAME.ino patten !
                PORT ${ARDUINO_DEFAULT_PORT}
                BOARD_CPU ${ARDUINO_CPU}
                )

