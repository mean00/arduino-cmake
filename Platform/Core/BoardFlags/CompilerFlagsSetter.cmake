#=============================================================================#
# _sanitize_quotes
# [PRIVATE/INTERNAL]
#
# _sanitize_quotes(CMD_LINE_VARIABLE)
#
#       CMD_LINE_VARIABLE - Variable holding a shell command line 
#                           or command line flag(s) that potentially 
#                           require(s) quotes to be fixed.
#
# Replaces Unix-style quotes with Windows-style quotes.
# '-DSOME_MACRO="foo"' would become "-DSOME_MACRO=\"foo\"".
#
#=============================================================================#
function(_sanitize_quotes
   CMD_LINE_VARIABLE
)
   if(CMAKE_HOST_WIN32)
   
      # Important: The order of the statements below does matter!
   
      # First replace all occurences of " with \"
      #
      string(REPLACE "\"" "\\\"" output "${${CMD_LINE_VARIABLE}}")
      
      # Then replace all ' with "
      #
      string(REPLACE "'" "\"" output "${output}")
      
      set(${CMD_LINE_VARIABLE} "${output}" PARENT_SCOPE)
   endif()
endfunction()

# ToDo: Comment
function(set_board_compiler_flags COMPILER_FLAGS NORMALIZED_SDK_VERSION BOARD_ID IS_MANUAL)
    include(${CMAKE_CURRENT_LIST_DIR}/cmake/Platform/Core/BoardFlags/CompilerFlagsSetter${PLATFORM_ARCHITECTURE_POSTFIX}.cmake)
    _try_get_board_property(${BOARD_ID} build.vid VID)
    _try_get_board_property(${BOARD_ID} build.pid PID)
    if (VID)
        set(COMPILE_FLAGS "${COMPILE_FLAGS} -DUSB_VID=${VID}")
    endif ()
    if (PID)
        set(COMPILE_FLAGS "${COMPILE_FLAGS} -DUSB_PID=${PID}")
    endif ()
    
    _try_get_board_property(${BOARD_ID} build.extra_flags EXTRA_FLAGS)

    if(NOT "${EXTRA_FLAGS}" STREQUAL "")
       _sanitize_quotes(EXTRA_FLAGS)
       set(COMPILE_FLAGS "${COMPILE_FLAGS} ${EXTRA_FLAGS}")
    endif()
    
    _try_get_board_property(${BOARD_ID} build.usb_flags USB_FLAGS)
    if(NOT "${USB_FLAGS}" STREQUAL "")
       _sanitize_quotes(USB_FLAGS)
       set(COMPILE_FLAGS "${COMPILE_FLAGS} ${USB_FLAGS}")
    endif()

    if (NOT IS_MANUAL)
        _get_board_property(${BOARD_ID} build.core BOARD_CORE)
        set(COMPILE_FLAGS "${COMPILE_FLAGS} -I\"${${BOARD_CORE}.path}\" -I\"${ARDUINO_LIBRARIES_PATH}\"")
        if (${ARDUINO_PLATFORM_LIBRARIES_PATH})
            set(COMPILE_FLAGS "${COMPILE_FLAGS} -I\"${ARDUINO_PLATFORM_LIBRARIES_PATH}\"")
        endif ()
    endif ()
    if (ARDUINO_SDK_VERSION VERSION_GREATER 1.0 OR ARDUINO_SDK_VERSION VERSION_EQUAL 1.0)
        if (NOT IS_MANUAL)
            _get_board_property(${BOARD_ID} build.variant VARIANT)
            set(PIN_HEADER ${${VARIANT}.path})
            if (PIN_HEADER)
                set(COMPILE_FLAGS "${COMPILE_FLAGS} -I\"${PIN_HEADER}\"")
            endif ()
        endif ()
    endif ()

    set(${COMPILER_FLAGS} "${COMPILE_FLAGS}" PARENT_SCOPE)

endfunction()
