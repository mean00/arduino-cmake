
This is in-progress work so that the *VERY* nice arduino-cmake project supports STM32 based board.
(it's easy to extend to others)

Installation : 

- Install a toolchain. Simplest is to use the arduino ide and install either SAM Board (32 bits ARM Cortex M3) or or STM32 cores by ST
. The ST one is significantly more recent. Write down the path to the arm-none-eabi-gcc and friends

- Install the Arduino STM32 files from here (https://github.com/rogerclarkmelbourne/Arduino_STM32). Either put the files in ARDUINO_SDK/harwdare/arduino or anywhere else you want.
That last folder *must* be  named arduino (i.e. /foo/bar/arduino/STM32F1 /foo/bar/arduino/drivers...)

- Be sure you have a STLINKv2 clone and that you know how to reflash the bootloader
(i.e. cd /opt/arduino-1.8.5/hardware/STM32/arduino/tools/linux64/stlink && ./st-flash  write ~/Arduino_stm32/STM32duino-bootloader/binaries/generic_boot20_pc13.bin 0x8000000)

- Copy the example/stm32 content somewhere so that you have
 Cmakelists.txt
 Hello.ino
 cmake/   (symlink to the cmake subfolder of arduino-cmake, or just copy it)

- Change the cmakelists.txt and use paths you noted before (toolchain &  arduino STM32 file in the  example)

- cmake .. && make

You now have the elf & bin files that you can upload manually

 /opt/arduino-1.8.5/hardware/Arduino_STM32-master/tools/linux/maple_upload ttyACM0 2 1EAF:0003 the_file.bin

1EAF:0003 is the usb id, it can change a bit, mine is 1eaf:0004, lsusb will tell you what you have

Important: 
  - Normally, the compatibility is kept for avr boards too. So you can use the same cmake setup for both AVR and STM32 boards.
  - Tested only on linux, might not work well on OsX and Windows
