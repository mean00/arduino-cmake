OPTION(USE_GD32F103   "Use GD32F103 MCU" FALSE) 
OPTION(USE_GD32F303   "Use GD32F303 MCU" FALSE) 
# Select platform and installation for extra arduino files AND toolchain (compiler...)
SET(PLATFORM_ARCHITECTURE "STM32F1")

IF(NOT MCU_SPEED)
    IF(USE_GD32F103 OR USE_GD32F303)
        SET(MCU_SPEED             96000000)                 # Max speed, above 96M USB will not work (?)
    ELSE(USE_GD32F103 OR USE_GD32F303)
        SET(MCU_SPEED             72000000)                 # Max speed, above 96M USB will not work (?)
    ENDIF(USE_GD32F103 OR USE_GD32F303)
ENDIF(NOT MCU_SPEED)

# Board setup
IF(USE_GD32F103)
    SET(EXTENSION             "GD32F103")
    set(X_ARDUINO_DEFAULT_BOARD genericGD32F103C)        # Default Board ID, when not specified
    set(X_ARDUINO_CPU           GD32F103C8)
    ADD_DEFINITIONS("-DHIGH_SPEED_ADC")
    SET(X_ARDUINO_UPLOAD_METHOD BMP) # Use blackmagic link, if you comment it out you'll use DFU => 8kB flash
    SET(ARDUINO_LD_SCRIPT "-T${CMAKE_CURRENT_SOURCE_DIR}/ldScript/GD32F1/gd32f1.ld -L${CMAKE_CURRENT_SOURCE_DIR}/ldScript/common ")
ELSEIF(USE_GD32F303)
    SET(EXTENSION             "GD32F303")
    set(X_ARDUINO_DEFAULT_BOARD genericGD32F303C)        # Default Board ID, when not specified
    set(X_ARDUINO_CPU           GD32F303C8)
    SET(USE_FPU TRUE)
    IF(USE_FPU )
        # FPU
        ADD_DEFINITIONS("-DUSE_FPU=1")
        SET(ARDUINO_MCU_FLAGS               "  -mcpu=cortex-m4  -mfloat-abi=hard -mfpu=fpv4-sp-d16  -mthumb")# -mfpu=fpv4-sp-d16")
    ELSE(USE_FPU )
        SET(ARDUINO_MCU_FLAGS               "  -mcpu=cortex-m4 -mfloat-abi=softfp  -mthumb")# -mfpu=fpv4-sp-d16")
    ENDIF(USE_FPU)
    ADD_DEFINITIONS("-DHIGH_SPEED_ADC")
    SET(X_ARDUINO_UPLOAD_METHOD BMP) # Use blackmagic link, if you comment it out you'll use DFU => 8kB flash
    SET(ARDUINO_LD_SCRIPT "-T${CMAKE_CURRENT_SOURCE_DIR}/ldScript/GD32F3/gd32f3.ld -L${CMAKE_CURRENT_SOURCE_DIR}/ldScript/common ")
ELSE()
    SET(EXTENSION             "STM32F103")
    set(X_ARDUINO_LD_FILE      jtag)      # Use that instead of default jtag-c8 to get the full 128 kB
    set(X_ARDUINO_DEFAULT_BOARD genericSTM32F103C)        # Default Board ID, when not specified
    set(X_ARDUINO_CPU           STM32F103C8)
    SET(X_ARDUINO_UPLOAD_METHOD BMP) # Use blackmagic link, if you comment it out you'll use DFU => 8kB flash
    SET(ARDUINO_LD_SCRIPT "-T${CMAKE_CURRENT_SOURCE_DIR}/ldScript/STM32F1/stm32f1.ld -L${CMAKE_CURRENT_SOURCE_DIR}/ldScript/common ")
ENDIF(USE_GD32F103)
