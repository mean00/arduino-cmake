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
MESSAGE(STATUS "Starting hello-esp32")
#
#
#
Project("Hello_esp32" C CXX ASM) # ASM must be present !
MESSAGE(STATUS "Dumping board")
print_board_list()
#
# that changes the way the binary is linked, better to use DFU in all cases !
SET(ARDUINO_UPLOAD_METHOD DFUUpload)

#
set(ARDUINO_DEFAULT_BOARD esp32) # Default Board ID, when not specified
#set(ARDUINO_DEFAULT_PORT  ttyACM0) # Default Port, when not specified
#set(ARDUINO_CPU           STM32F103C8)
#
generate_arduino_firmware(GetChipID 
                SKETCH GetChipID.ino              # Folder to get the .ino from, must follow DIR_NAME/DIR_NAME.ino patten !
                PORT ${ARDUINO_DEFAULT_PORT}
                )
#--------------------------------------------------------------------------------------
