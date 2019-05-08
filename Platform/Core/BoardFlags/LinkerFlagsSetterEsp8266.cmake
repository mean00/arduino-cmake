# ToDo: Comment
# -Wl,--no-check-sections -u app_entry -u _printf_float -u _scanf_float -Wl,-static "-L/home/fx/.arduino15/packages/esp8266/hardware/esp8266/2.5.0/tools/sdk/lib" "-L/home/fx/.arduino15/packages/esp8266/hardware/esp8266/2.5.0/tools/sdk/ld" "-L/home/fx/.arduino15/packages/esp8266/hardware/esp8266/2.5.0/tools/sdk/libc/xtensa-lx106-elf/lib" "-Teagle.flash.512k.ld" -Wl,--gc-sections -Wl,-wrap,system_restart_local -Wl,-wrap,spi_flash_read  -o "/tmp/arduino_build_251883/Blink.ino.elf" -Wl,--start-group "/tmp/arduino_build_251883/sketch/Blink.ino.cpp.o" "/tmp/arduino_build_251883/core/core.a" -lhal -lphy -lpp -lnet80211 -llwip2-536-feat -lwpa -lcrypto -lmain -lwps -lbearssl -laxtls -lespnow -lsmartconfig -lairkiss -lwpa2 -lstdc++ -lm -lc -lgcc -Wl,--end-group  "-L/tmp/arduino_build_251883"
#"/home/fx/.arduino15/packages/esp8266/tools/esptool/2.5.0-3-20ed2b9/esptool" -eo "/home/fx/.arduino15/packages/esp8266/hardware/esp8266/2.5.0/bootloaders/eboot/eboot.elf" -bo "/tmp/arduino_build_251883/Blink.ino.bin" -bm dout -bf 40 -bz 512K -bs .text -bp 4096 -ec -eo "/tmp/arduino_build_251883/Blink.ino.elf" -bs .irom0.text -bs .text -bs .data -bs .rodata -bc -ec
#python "/home/fx/.arduino15/packages/esp8266/hardware/esp8266/2.5.0/tools/signing.py" --mode sign --privatekey "/home/fx/.arduino15/packages/esp8266/hardware/esp8266/2.5.0/libraries/esp8266/examples/Blink/private.key" --bin "/tmp/arduino_build_251883/Blink.ino.bin" --out "/tmp/arduino_build_251883/Blink.ino.bin.signed"
#

function(set_board_linker_flags LINKER_FLAGS BOARD_ID IS_MANUAL)

    set(LINK_FLAGS "${LINK_FLAGS} -Wl,--no-check-sections -u app_entry -u _printf_float -u _scanf_float \"-Teagle.flash.512k.ld\" -Wl,--gc-sections -Wl,-wrap,system_restart_local -Wl,-wrap,spi_flash_read ")
    set(LINK_FLAGS "${LINK_FLAGS} -Wl,--unresolved-symbols=report-all -Wl,--warn-common -Wl,--warn-section-align -lstdc++ -L${PLATFORM_PATH}/tools/sdk/lib")
#-Wl,--warn-unresolved-symbols -lstdc++")
    set(${LINKER_FLAGS} "${LINK_FLAGS}" PARENT_SCOPE)

endfunction()
