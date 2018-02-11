# ToDo: Comment
function(set_board_linker_flags LINKER_FLAGS BOARD_ID IS_MANUAL)

#    _get_board_property(${BOARD_ID} build.mcu MCU)
    #set(LINK_FLAGS "-mmcu=${MCU}")
    #set(LINK_FLAGS "${LINK_FLAGS} -Wl,--cref") 
    set(LINK_FLAGS "${LINK_FLAGS} -Wl,--check-sections -Wl,--gc-sections ")
    set(LINK_FLAGS "${LINK_FLAGS} -Wl,--unresolved-symbols=report-all -Wl,--warn-common -Wl,--warn-section-align -Wl,--warn-unresolved-symbols -lstdc++")
    set(${LINKER_FLAGS} "${LINK_FLAGS}" PARENT_SCOPE)

endfunction()
