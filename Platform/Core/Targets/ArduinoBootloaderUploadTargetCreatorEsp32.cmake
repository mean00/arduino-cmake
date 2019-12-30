

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
    add_custom_target(${UPLOAD_TARGET}
            ${PLATFORM_PATH}/tools/esptool/esptool.py --chip esp32 --port "/dev/${ARDUINO_DEFAULT_PORT}" --baud ${ESP32_USB_UPLOAD_SPEED}  --before default_reset --after hard_reset write_flash -z --flash_mode ${ESP32_FLASH_MODE} --flash_freq ${ESP32_FLASH_SPEED} --flash_size detect 0xe000 "${PLATFORM_PATH}/tools/partitions/boot_app0.bin" 0x1000 "${PLATFORM_PATH}/tools/sdk/bin/bootloader_${ESP32_FLASH_MODE_BOOTLOADER}_${ESP32_FLASH_SPEED}.bin"  0x10000 ${TARGET_NAME}.img.bin 0x8000 "${TARGET_NAME}.partitions.bin"
            DEPENDS ${TARGET_NAME})

    # Global upload target
    if (NOT TARGET upload)
        add_custom_target(upload)
    endif ()

    add_dependencies(upload ${UPLOAD_TARGET})
endfunction()
