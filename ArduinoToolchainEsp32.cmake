#=============================================================================#
# Author: Tomasz Bogdal (QueezyTheGreat)
# Home:   https://github.com/queezythegreat/arduino-cmake
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this file,
# You can obtain one at http://mozilla.org/MPL/2.0/.
#=============================================================================#
MESSAGE(STATUS "Setting up ESP32 arduino cmake environment")
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
#  -L/home/fx/Arduino/hardware/espressif/esp32/tools/sdk/lib 
SET(ESP32_LIBS  "-lgcc -lesp32 -lphy -lesp_http_client -lmbedtls -lrtc -lesp_http_server -lbtdm_app -lspiffs -lbootloader_support -lmdns -lnvs_flash -lfatfs -lpp -lnet80211 -ljsmn -lface_detection -llibsodium -lvfs -ldl_lib -llog -lfreertos -lcxx -lsmartconfig_ack -lxtensa-debug-module -lheap -ltcpip_adapter -lmqtt -lulp -lfd -lfb_gfx -lnghttp -lprotocomm -lsmartconfig -lm -lethernet -limage_util -lc_nano -lsoc -ltcp_transport -lc -lmicro-ecc -lface_recognition -ljson -lwpa_supplicant -lmesh -lesp_https_ota -lwpa2 -lexpat -llwip -lwear_levelling -lapp_update -ldriver -lbt -lespnow -lcoap -lasio -lnewlib -lconsole -lapp_trace -lesp32-camera -lhal -lprotobuf-c -lsdmmc -lcore -lpthread -lcoexist -lfreemodbus -lspi_flash -lesp-tls -lwpa -lwifi_provisioning -lwps -lesp_adc_cal -lesp_event -lopenssl -lesp_ringbuf -lfr -lstdc++ ")
SET(ESP32_OPTS " -Wl,-EL    -u ld_include_panic_highint_hdl -u call_user_start_cpu0  -Wl,-static -Wl,--undefined=uxTopUsedPriority -u __cxa_guard_dummy -u __cxx_fatal_exception  ")
SET(ESP32_LD  "-T esp32_out.ld -T esp32.common.ld -T esp32.rom.ld -T esp32.peripherals.ld -T esp32.rom.libgcc.ld -T esp32.rom.spiram_incompatible_fns.ld ")
#
 set(CMAKE_CXX_LINK_EXECUTABLE    "<CMAKE_C_COMPILER>   <CMAKE_CXX_LINK_FLAGS>  -nostdlib -L${PLATFORM_PATH}/tools/sdk/ld/ -L${PLATFORM_PATH}/tools/sdk/lib <LINK_FLAGS>   ${ESP32_LD}  ${ESP32_OPTS}-Wl,--start-group  <OBJECTS> <LINK_LIBRARIES>  ${ESP32_LIBS} -Wl,--end-group -Wl,-EL  -o <TARGET> ")
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

#dump_all()

