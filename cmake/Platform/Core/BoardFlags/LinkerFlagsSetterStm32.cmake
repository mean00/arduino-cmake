# ToDo: Comment
function(set_board_linker_flags LINKER_FLAGS BOARD_ID IS_MANUAL)

    set(LINK_FLAGS "${LINK_FLAGS} -Os  -Wl,--gc-sections -mcpu=cortex-m3")
    set(LINK_FLAGS "${LINK_FLAGS} -Wl,--unresolved-symbols=report-all -Wl,--warn-common -Wl,--warn-section-align -Wl,--warn-unresolved-symbols -lstdc++")
    set(${LINKER_FLAGS} "${LINK_FLAGS}" PARENT_SCOPE)

endfunction()
