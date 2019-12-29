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
IF(NOT PLATFORM_TOOLCHAIN_PATH)
        MESSAGE(FATAL_ERROR "PLATFORM_TOOLCHAIN_PATH is not defined !")
ENDIF(NOT PLATFORM_TOOLCHAIN_PATH)
#


LIST(APPEND CMAKE_SYSTEM_PREFIX_PATH "${PLATFORM_TOOLCHAIN_PATH}")
SET(ESP32_TOOLCHAIN_PREFIX xtensa-esp32-elf-)

FUNCTION(FATAL_BANNER msg)
    MESSAGE(STATUS "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")
    MESSAGE(STATUS "${msg}")
    MESSAGE(STATUS "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")
    MESSAGE(FATAL_ERROR "${msg}")
ENDFUNCTION(FATAL_BANNER msg)

#
# Sanity check
#
IF(NOT EXISTS "${PLATFORM_TOOLCHAIN_PATH}/${ESP32_TOOLCHAIN_PREFIX}gcc")
   FATAL_BANNER( "!! PLATFORM_TOOLCHAIN_PATH does not point to a valid toolchain (arm-none-eabi-gcc....)!! (${PLATFORM_TOOLCHAIN_PATH})")
ENDIF()
#
#
SET(CMAKE_C_COMPILER_ID   "GNU" CACHE INTERNAL "")
SET(CMAKE_CXX_COMPILER_ID "GNU" CACHE INTERNAL "")
#
set(CMAKE_C_COMPILER   ${PLATFORM_TOOLCHAIN_PATH}/${ESP32_TOOLCHAIN_PREFIX}gcc CACHE PATH "" FORCE)
set(CMAKE_ASM_COMPILER ${PLATFORM_TOOLCHAIN_PATH}/${ESP32_TOOLCHAIN_PREFIX}gcc CACHE PATH "" FORCE)
set(CMAKE_CXX_COMPILER ${PLATFORM_TOOLCHAIN_PATH}/${ESP32_TOOLCHAIN_PREFIX}g++ CACHE PATH "" FORCE)
 #set(CMAKE_CXX_LINK_EXECUTABLE    "<CMAKE_CXX_COMPILER>  <FLAGS> <CMAKE_CXX_LINK_FLAGS>  <LINK_FLAGS> <OBJECTS>  -o <TARGET> <LINK_LIBRARIES>")
# There is probably a cleaner way to do this....
# /home/fx/Arduino/hardware/espressif/esp32/tools/xtensa-esp32-elf/bin/xtensa-esp32-elf-gcc -nostdlib -L/home/fx/Arduino/hardware/espressif/esp32/tools/sdk/lib -L/home/fx/Arduino/hardware/espressif/esp32/tools/sdk/ld -T esp32_out.ld -T esp32.common.ld -T esp32.rom.ld -T esp32.peripherals.ld -T esp32.rom.libgcc.ld -T esp32.rom.spiram_incompatible_fns.ld -u ld_include_panic_highint_hdl -u call_user_start_cpu0 -Wl,--gc-sections -Wl,-static -Wl,--undefined=uxTopUsedPriority -u __cxa_guard_dummy -u __cxx_fatal_exception -Wl,--start-group /tmp/arduino_build_362873/sketch/GetChipID.ino.cpp.o /tmp/arduino_cache_671610/core/core_fa51f82175cf2dd1c3422f76e57c15bd.a -lgcc -lesp32 -lphy -lesp_http_client -lmbedtls -lrtc -lesp_http_server -lbtdm_app -lspiffs -lbootloader_support -lmdns -lnvs_flash -lfatfs -lpp -lnet80211 -ljsmn -lface_detection -llibsodium -lvfs -ldl_lib -llog -lfreertos -lcxx -lsmartconfig_ack -lxtensa-debug-module -lheap -ltcpip_adapter -lmqtt -lulp -lfd -lfb_gfx -lnghttp -lprotocomm -lsmartconfig -lm -lethernet -limage_util -lc_nano -lsoc -ltcp_transport -lc -lmicro-ecc -lface_recognition -ljson -lwpa_supplicant -lmesh -lesp_https_ota -lwpa2 -lexpat -llwip -lwear_levelling -lapp_update -ldriver -lbt -lespnow -lcoap -lasio -lnewlib -lconsole -lapp_trace -lesp32-camera -lhal -lprotobuf-c -lsdmmc -lcore -lpthread -lcoexist -lfreemodbus -lspi_flash -lesp-tls -lwpa -lwifi_provisioning -lwps -lesp_adc_cal -lesp_event -lopenssl -lesp_ringbuf -lfr -lstdc++ -Wl,--end-group -Wl,-EL -o /tmp/arduino_build_362873/GetChipID.ino.elf

 set(CMAKE_CXX_LINK_EXECUTABLE    "<CMAKE_CXX_COMPILER>   <CMAKE_CXX_LINK_FLAGS>  <LINK_FLAGS> -lgcc -mthumb -Wl,--start-group  <OBJECTS> <LINK_LIBRARIES> -Wl,--end-group   -o <TARGET> ")
#set(CMAKE_EXE_LINKER_FLAGS "" CACHE INTERNAL "")
#set(CMAKE_CXX_LINK_FLAGS   "" CACHE INTERNAL "")
#set(CMAKE_C_LINK_FLAGS     "" CACHE INTERNAL "")
#set(CMAKE_CXX_LINK_EXECUTABLE "echo CXXFLAGS: ${CMAKE_CXX_FLAGS} LINK_FLAGS: <LINK_FLAGS> LINK_LIBRARIES: <LINK_LIBRARIES> OBJECTS: <OBJECTS>")

MESSAGE(STATUS "C   compiler ${CMAKE_C_COMPILER}")
MESSAGE(STATUS "C++ compiler ${CMAKE_CXX_COMPILER}")

if (ARDUINO_SDK_PATH)
    set(ENV{_ARDUINO_CMAKE_WORKAROUND_ARDUINO_SDK_PATH} "${ARDUINO_SDK_PATH}")
else ()
    message(FATAL_ERROR "Could not find Arduino SDK (set ARDUINO_SDK_PATH)!")
endif ()

