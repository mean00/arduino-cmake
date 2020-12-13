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
    if(ARDUINO_CMAKE_GENERATE_SHARED_LIBRARIES)
        add_library(${TARGET_NAME} SHARED "${ALL_SRCS}")
    else()
        # Here we add the content of the wirish subfolder for the variant 
        # + the board.cpp files
        MESSAGE(STATUS "Adding runtime wirish files from ${RUNTIME_FILES_PATH}")
        #file(GLOB WIRISH ${RUNTIME_FILES_PATH}/wirish/*.*)
        #FOREACH(w ${WIRISH})
            #SET(wirish_files ${wirish_files} ${w})
        #ENDFOREACH(w ${WIRISH})
        #MESSAGE(STATUS "${wirish_files}")
        #Order is important
        FOREACH(src start.S  start_c.c  syscalls.c ../board.cpp boards.cpp  boards_setup.cpp  )
            SET(wirish_files ${wirish_files} ${RUNTIME_FILES_PATH}/wirish/${src} )
        ENDFOREACH(src boards.cpp  boards_setup.cpp  start_c.c  start.S  syscalls.c)
        MESSAGE(STATUS "${wirish_files}")
    
        #get_cmake_property(_variableNames VARIABLES)
        #foreach (_variableName ${_variableNames})
            #message(STATUS "${_variableName}=${${_variableName}}")
        #endforeach()
        add_executable(${TARGET_NAME} ${wirish_files} ${ALL_SRCS})
    endif()
    set_target_properties(${TARGET_NAME} PROPERTIES SUFFIX ".elf")

    # depending on the upload method we use different ld script
    # let's hardcode to bootloader for now 
    #dump_all()
    # Check for blackMagic
    IF(NOT DEFINED ARDUINO_LD_SCRIPT)
        IF(ARDUINO_UPLOAD_METHOD MATCHES "BMP")
            IF(NOT DEFINED ARDUINO_LD_FILE)
                SET(BOOTLOADER_LINK_OPT  "-T${RUNTIME_FILES_PATH}/ld/jtag_c8.ld ") # Hack
            ELSE(NOT DEFINED ARDUINO_LD_FILE)
                SET(BOOTLOADER_LINK_OPT  "-T${RUNTIME_FILES_PATH}/ld/${ARDUINO_LD_FILE}.ld ") # Hack
            ENDIF(NOT DEFINED ARDUINO_LD_FILE)
        ELSE()
            if( DEFINED ${BOARD_ID}.menu.cpu.DFUUploadMethod.build.ldscript  )
                SET(BOOTLOADER_LINK_OPT  "-T${RUNTIME_FILES_PATH}/${${BOARD_ID}.menu.cpu.DFUUploadMethod.build.ldscript} ") # Hack
            else( DEFINED ${BOARD_ID}.menu.cpu.DFUUploadMethod.build.ldscript  )
                SET(BOOTLOADER_LINK_OPT  "-T${RUNTIME_FILES_PATH}/${${BOARD_ID}.menu.cpu.bootloader20.build.ldscript} ") # Hack
            endif( DEFINED ${BOARD_ID}.menu.cpu.DFUUploadMethod.build.ldscript  )
        ENDIF()
        SET(BOOTLOADER_LINK_OPT  "${BOOTLOADER_LINK_OPT} -L${RUNTIME_FILES_PATH}/ld") # Hack
    ELSE()
                SET(BOOTLOADER_LINK_OPT  "${ARDUINO_LD_SCRIPT} ") 
    ENDIF()

    MESSAGE(STATUS "Bootloader : <${BOOTLOADER_LINK_OPT}> , ARDUINO_LD_SCRIPT=${ARDUINO_LD_SCRIPT}")
    SET(MAP_OPT  "-Wl,-Map,${TARGET_NAME}.map")

    #
    set_board_flags(ARDUINO_COMPILE_FLAGS ARDUINO_LINK_FLAGS ${BOARD_ID} ${MANUAL})

    # Add ld script
    MESSAGE(STATUS "ARDUINO_LINK_FLAGS ${ARDUINO_LINK_FLAGS},  LINK_FLAGS: ${LINK_FLAGS}")
    set_target_properties(${TARGET_NAME} PROPERTIES
            COMPILE_FLAGS "${ARDUINO_COMPILE_FLAGS} ${COMPILE_FLAGS}"
            LINK_FLAGS "${ARDUINO_LINK_FLAGS} ${BOOTLOADER_LINK_OPT} ${LINK_FLAGS} ${MAP_OPT} ${LINK_FLAGS}")
            
    list(REMOVE_DUPLICATES ALL_LIBS)
    if(ARDUINO_CMAKE_GENERATE_SHARED_LIBRARIES)
      # When building a shared library we must make sure that
      # all symbols from the intermediate static libraries end up in the
      # static library
      #
      target_link_libraries(${TARGET_NAME} PUBLIC "-Wl,--whole-archive" ${ALL_LIBS} "-Wl,--no-whole-archive")
    else()
       FOREACH(item ${ALL_LIBS})
            DBG("\tFINAL LINK FLAGS : ${item}")
            #ADD_DEPENDENCIES(${TARGET_NAME} ${item})
            SET(FLAT_LIBS "${item} ${FLAT_LIBS}")
            target_link_libraries(${TARGET_NAME} ${item})
    ENDFOREACH(item ${ALL_LIBS})
  #target_link_libraries(${TARGET_NAME} "${FLAT_LIBS} -lc -lm")
    endif()
    
    if (NOT EXECUTABLE_OUTPUT_PATH)
        set(EXECUTABLE_OUTPUT_PATH ${CMAKE_CURRENT_BINARY_DIR})
    endif ()
    
    if(ARDUINO_CMAKE_ONLY_ELF)
       return()
    endif()
    
   # set(TARGET_PATH ${EXECUTABLE_OUTPUT_PATH}/${TARGET_NAME})
    #add_custom_command(TARGET ${TARGET_NAME} POST_BUILD
            #COMMAND ${CMAKE_OBJCOPY}
            #ARGS ${ARDUINO_OBJCOPY_EEP_FLAGS}
            #${TARGET_PATH}.elf
            #${TARGET_PATH}.eep
            #COMMENT "Generating EEP image"
            #VERBATIM)

    # Convert firmware image to ASCII HEX format
    add_custom_command(TARGET ${TARGET_NAME} POST_BUILD
            COMMAND ${CMAKE_OBJCOPY}
            ARGS -Oihex
            ${TARGET_NAME}.elf
            ${TARGET_NAME}.hex
            COMMENT "Generating HEX image"
            VERBATIM)
     add_custom_command(TARGET ${TARGET_NAME} POST_BUILD
            COMMAND ${CMAKE_OBJCOPY}
            ARGS -Obinary
            ${TARGET_NAME}.elf
            ${TARGET_NAME}.bin
            COMMENT "Generating BIN image"
            VERBATIM)
#_get_board_property(${BOARD_ID} build.mcu MCU)
    # Display target size
    #add_custom_command(TARGET ${TARGET_NAME} POST_BUILD
            #COMMAND ${CMAKE_COMMAND}
            #ARGS -DFIRMWARE_IMAGE=${TARGET_NAME}.elf
            #-DMCU=atmega1280
            #-DEEPROM_IMAGE=${TARGET_PATH}.eep
            #-P ${ARDUINO_SIZE_SCRIPT}
            #COMMENT "Calculating image size"
            #VERBATIM)

   
endfunction()
