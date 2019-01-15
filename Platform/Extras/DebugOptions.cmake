#=============================================================================#
# arduino_debug_on()
# [PRIVATE/INTERNAL]
#
#  arduino_debug_on()
#
# Enables Arduino module debugging.
#=============================================================================#
function(arduino_debug_on)
    set(ARDUINO_DEBUG True PARENT_SCOPE)
endfunction()

#=============================================================================#
# arduino_debug_on()
# [PRIVATE/INTERNAL]
#
#  arduino_debug_off()
#
# Disables Arduino module debugging.
#=============================================================================#
function(arduino_debug_off)
    set(ARDUINO_DEBUG False PARENT_SCOPE)
endfunction()

#=============================================================================#
# arduino_debug_msg
# [PRIVATE/INTERNAL]
#
# arduino_debug_msg(MSG)
#
#        MSG - Message to print
#
# Print Arduino debugging information. In order to enable printing
# use arduino_debug_on() and to disable use arduino_debug_off().
#=============================================================================#
function(arduino_debug_msg MSG)
    if (ARDUINO_DEBUG)
        message("## ${MSG}")
    endif ()
endfunction()
