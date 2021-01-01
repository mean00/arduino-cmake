rm -Rf STM32F1/patched STM32F1/variants/generic_gd32f103c2/ STM32F1/variants/generic_gd32f303c/
rm -Rf STM32F1/patched*
git checkout STM32F1/boards.txt STM32F1/system/libmaple/stm32f1/include/series/stm32.h
git checkout STM32F1/variants/generic_stm32f103c/board.cpp
git checkout STM32F1/cores/maple/main.cpp
git checkout STM32F1/cores/maple/libmaple/i2c.c
git checkout STM32F1/cores/maple/libmaple/i2c_f1.c
git checkout STM32F1/libraries/SPI/src/SPI.cpp
git checkout STM32F1/libraries/SPI/src/SPI.h
