#=============================================================================#
# generate_arduino_library
# [PUBLIC/USER]
# see documentation at README
#=============================================================================#
function(generate_arduino_library INPUT_NAME)
    message(STATUS "Generating Library ${INPUT_NAME}")
    parse_generator_arguments(${INPUT_NAME} INPUT
            "NO_AUTOLIBS;MANUAL"                  # Options
            "BOARD;BOARD_CPU"                     # One Value Keywords
            "SRCS;HDRS;LIBS"                      # Multi Value Keywords
            ${ARGN})

    if (NOT INPUT_BOARD)
        set(INPUT_BOARD ${ARDUINO_DEFAULT_BOARD})
    endif ()
    if (NOT INPUT_BOARD_CPU AND ARDUINO_DEFAULT_BOARD_CPU)
        set(INPUT_BOARD_CPU ${ARDUINO_DEFAULT_BOARD_CPU})
    endif ()
    if (NOT INPUT_MANUAL)
        set(INPUT_MANUAL FALSE)
    endif ()
    validate_variables_not_empty(VARS INPUT_SRCS INPUT_BOARD MSG "must define for target ${INPUT_NAME}")

    _get_board_id(${INPUT_BOARD} "${INPUT_BOARD_CPU}" ${INPUT_NAME} BOARD_ID)

    set(ALL_LIBS)
    set(ALL_SRCS ${INPUT_SRCS} ${INPUT_HDRS})


    find_arduino_libraries(TARGET_LIBS "${ALL_SRCS}" "")
    set(LIB_DEP_INCLUDES)
    foreach (LIB_DEP ${TARGET_LIBS})
        LIST(APPEND LIB_DEP_INCLUDES ${LIB_DEP})
    endforeach ()

    list(APPEND ALL_LIBS ${CORE_LIB} ${INPUT_LIBS})

    add_library(${INPUT_NAME} ${ALL_SRCS})

    set_board_flags(ARDUINO_COMPILE_FLAGS ARDUINO_LINK_FLAGS ${BOARD_ID} ${INPUT_MANUAL})

    separate_arguments(my_ARDUINO_COMPILE_FLAGS UNIX_COMMAND "${ARDUINO_COMPILE_FLAGS}")
    target_compile_options( ${INPUT_NAME} PRIVATE ${my_ARDUINO_COMPILE_FLAGS} )
    target_compile_options( ${INPUT_NAME} PRIVATE  ${COMPILE_FLAGS} )
    target_include_directories(${INPUT_NAME} PUBLIC ${LIB_DEP_INCLUDES})
endfunction()
