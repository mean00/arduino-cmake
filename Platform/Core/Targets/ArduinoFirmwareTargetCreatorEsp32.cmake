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

 
endfunction()
