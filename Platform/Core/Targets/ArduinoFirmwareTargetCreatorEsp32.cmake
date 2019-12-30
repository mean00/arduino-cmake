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

    string(STRIP "${ALL_SRCS}" ALL_SRCS)
    set(VARIANT_FOLDER ${${BOARD_ID}.build.variant})
    set(RUNTIME_FILES_PATH ${${VARIANT_FOLDER}.path})
    add_executable(${TARGET_NAME}  ${ALL_SRCS})
    set_target_properties(${TARGET_NAME} PROPERTIES SUFFIX ".elf")

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
  add_custom_command(TARGET ${TARGET_NAME} POST_BUILD
            COMMAND cp ${PLATFORM_PATH}//tools/partitions/default.csv partitions.csv
            COMMENT "Copying partitions bin scheme"
            VERBATIM)



    add_custom_command(TARGET ${TARGET_NAME} POST_BUILD
            COMMAND python ${PLATFORM_PATH}/tools/gen_esp32part.py --flash-size ${ESP32_FLASH_SIZE}MB -q partitions.csv ${TARGET_NAME}.partitions.bin
            COMMENT "Generating partitions bin image"
            VERBATIM)

     add_custom_command(TARGET ${TARGET_NAME} POST_BUILD
            COMMAND python ${PLATFORM_PATH}/tools/esptool/esptool.py --chip esp32 elf2image --flash_mode ${ESP32_FLASH_MODE} --flash_freq ${ESP32_FLASH_SPEED} --flash_size ${ESP32_FLASH_SIZE}MB -o ${TARGET_NAME}.img.bin ${TARGET_NAME}.elf
            COMMENT "Generating bin image"
            VERBATIM)
 
endfunction()
