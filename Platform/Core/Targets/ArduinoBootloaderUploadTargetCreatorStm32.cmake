

#=============================================================================#
# setup_arduino_bootloader_upload
# [PRIVATE/INTERNAL]
#
# setup_arduino_bootloader_upload(TARGET_NAME BOARD_ID PORT)
#
#      TARGET_NAME - target name
#      BOARD_ID    - board id
#      PORT        - serial port
#      AVRDUDE_FLAGS - avrdude flags (override)
#
# Set up target for upload firmware via the bootloader.
#
# The target for uploading the firmware is ${TARGET_NAME}-upload .
#
#=============================================================================#
function(create_arduino_bootloader_upload_target TARGET_NAME BOARD_ID PORT AVRDUDE_FLAGS)
    set(UPLOAD_TARGET ${TARGET_NAME}-upload)
    set(AVRDUDE_ARGS)

    build_arduino_bootloader_arguments(${BOARD_ID} ${TARGET_NAME} ${PORT} "${AVRDUDE_FLAGS}" AVRDUDE_ARGS)
    if (NOT EXECUTABLE_OUTPUT_PATH)
        set(EXECUTABLE_OUTPUT_PATH ${CMAKE_CURRENT_BINARY_DIR})
    endif ()
    set(TARGET_PATH ${EXECUTABLE_OUTPUT_PATH}/${TARGET_NAME})

    IF(ARDUINO_USB_PID)
        SET(USB_PID "${ARDUINO_USB_PID}")
    ELSE(ARDUINO_USB_PID)
        SET(USB_PID "0004") # Default value
    ENDIF(ARDUINO_USB_PID)
    IF(NOT DEFINED(MAPLE_UPLOAD))
        SET(MAPLE_UPLOAD ${ORIGINAL_PLATFORM_PATH}/tools/linux/maple_upload CACHE INTERNAL "")
    ENDIF(NOT DEFINED(MAPLE_UPLOAD))

    add_custom_target(${UPLOAD_TARGET}
            ${MAPLE_UPLOAD}
            ${PORT} 2 1EAF:${USB_PID} 
            ${TARGET_PATH}.bin
            DEPENDS ${TARGET_NAME})

    # Global upload target
    if (NOT TARGET upload)
        add_custom_target(upload)
    endif ()

    add_dependencies(upload ${UPLOAD_TARGET})
endfunction()
