#=============================================================================#
# create_arduino_target
# [PRIVATE/INTERNAL]
#
# create_arduino_target(TARGET_NAME ALL_SRCS ALL_LIBS COMPILE_FLAGS LINK_FLAGS MANUAL)
#
#        TARGET_NAME - Target name
#        BOARD_ID    - Arduino board ID
#        ALL_SRCS    - All sources
#        ALL_LIBS    - All libraries
#        COMPILE_FLAGS - Compile flags
#        LINK_FLAGS    - Linker flags
#        MANUAL - (Advanced) Only use AVR Libc/Includes
#
# Creates an Arduino firmware target.
#
#=============================================================================#

MACRO(DBG)
        #MESSAGE(STATUS ${ARGN})
ENDMACRO(DBG)

function(create_arduino_firmware_target TARGET_NAME BOARD_ID ALL_SRCS ALL_LIBS
        COMPILE_FLAGS LINK_FLAGS MANUAL)


#/home/fx/Arduino/hardware/espressif/esp32/tools/xtensa-esp32-elf/bin/xtensa-esp32-elf-gcc -nostdlib -L/home/fx/Arduino/hardware/espressif/esp32/tools/sdk/lib -L/home/fx/Arduino/hardware/espressif/esp32/tools/sdk/ld -T esp32_out.ld -T esp32.common.ld -T esp32.rom.ld -T esp32.peripherals.ld -T esp32.rom.libgcc.ld -T esp32.rom.spiram_incompatible_fns.ld -u ld_include_panic_highint_hdl -u call_user_start_cpu0 -Wl,--gc-sections -Wl,-static -Wl,--undefined=uxTopUsedPriority -u __cxa_guard_dummy -u __cxx_fatal_exception -Wl,--start-group /tmp/arduino_build_362873/sketch/GetChipID.ino.cpp.o /tmp/arduino_cache_671610/core/core_fa51f82175cf2dd1c3422f76e57c15bd.a -lgcc -lesp32 -lphy -lesp_http_client -lmbedtls -lrtc -lesp_http_server -lbtdm_app -lspiffs -lbootloader_support -lmdns -lnvs_flash -lfatfs -lpp -lnet80211 -ljsmn -lface_detection -llibsodium -lvfs -ldl_lib -llog -lfreertos -lcxx -lsmartconfig_ack -lxtensa-debug-module -lheap -ltcpip_adapter -lmqtt -lulp -lfd -lfb_gfx -lnghttp -lprotocomm -lsmartconfig -lm -lethernet -limage_util -lc_nano -lsoc -ltcp_transport -lc -lmicro-ecc -lface_recognition -ljson -lwpa_supplicant -lmesh -lesp_https_ota -lwpa2 -lexpat -llwip -lwear_levelling -lapp_update -ldriver -lbt -lespnow -lcoap -lasio -lnewlib -lconsole -lapp_trace -lesp32-camera -lhal -lprotobuf-c -lsdmmc -lcore -lpthread -lcoexist -lfreemodbus -lspi_flash -lesp-tls -lwpa -lwifi_provisioning -lwps -lesp_adc_cal -lesp_event -lopenssl -lesp_ringbuf -lfr -lstdc++ -Wl,--end-group -Wl,-EL -o /tmp/arduino_build_362873/GetChipID.ino.elf


    string(STRIP "${ALL_SRCS}" ALL_SRCS)
    set(VARIANT_FOLDER ${${BOARD_ID}.build.variant})
    set(RUNTIME_FILES_PATH ${${VARIANT_FOLDER}.path})
    add_executable(${TARGET_NAME}  ${ALL_SRCS})
    set_target_properties(${TARGET_NAME} PROPERTIES SUFFIX ".elf")


    IF(FALSE)
    # depending on the upload method we use different ld script
    # let's hardcode to bootloader for now 
    if( DEFINED ${BOARD_ID}.menu.cpu.DFUUploadMethod.build.ldscript  )
        SET(BOOTLOADER_LINK_OPT  "-T${RUNTIME_FILES_PATH}/${${BOARD_ID}.menu.cpu.DFUUploadMethod.build.ldscript} ") # Hack
    else( DEFINED ${BOARD_ID}.menu.cpu.DFUUploadMethod.build.ldscript  )
        SET(BOOTLOADER_LINK_OPT  "-T${RUNTIME_FILES_PATH}/${${BOARD_ID}.menu.cpu.bootloader20.build.ldscript} ") # Hack
    endif( DEFINED ${BOARD_ID}.menu.cpu.DFUUploadMethod.build.ldscript  )

    SET(BOOTLOADER_LINK_OPT  "${BOOTLOADER_LINK_OPT} -L${RUNTIME_FILES_PATH}/ld") # Hack
    MESSAGE(STATUS "Bootloader : <${BOOTLOADER_LINK_OPT}>")
    SET(MAP_OPT  "-Wl,-Map,${TARGET_NAME}.map")

    #
    ENDIF(FALSE)
    set_board_flags(ARDUINO_COMPILE_FLAGS ARDUINO_LINK_FLAGS ${BOARD_ID} ${MANUAL})
    # Add ld script
    MESSAGE(STATUS "ARDUINO_LINK_FLAGS ${ARDUINO_LINK_FLAGS},  LINK_FLAGS: ${LINK_FLAGS}")
    set_target_properties(${TARGET_NAME} PROPERTIES
            COMPILE_FLAGS "${ARDUINO_COMPILE_FLAGS} ${COMPILE_FLAGS}"
            LINK_FLAGS "${ARDUINO_LINK_FLAGS} ${BOOTLOADER_LINK_OPT} ${LINK_FLAGS} ${MAP_OPT} ${LINK_FLAGS}")
            
    list(REMOVE_DUPLICATES ALL_LIBS)
          FOREACH(item ${ALL_LIBS})
            DBG("\tFINAL LINK FLAGS : ${item}")
            SET(FLAT_LIBS "${item} ${FLAT_LIBS}")
            target_link_libraries(${TARGET_NAME} ${item})
          ENDFOREACH(item ${ALL_LIBS})
    
    if (NOT EXECUTABLE_OUTPUT_PATH)
        set(EXECUTABLE_OUTPUT_PATH ${CMAKE_CURRENT_BINARY_DIR})
    endif ()
     
    dump_all() 
     
      # Display target size
#    add_custom_command(TARGET ${TARGET_NAME} POST_BUILD
            #COMMAND ${PLATFORM_TOOLCHAIN_PATH}/${ESP32_TOOLCHAIN_PREFIX}size
            #ARGS -A=${TARGET_NAME}.elf
            #COMMENT "Calculating image size"
            #VERBATIM)

 
endfunction()
