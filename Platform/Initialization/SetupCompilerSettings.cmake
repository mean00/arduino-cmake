#=============================================================================#
#                              C Flags
#=============================================================================#
include(${ARDUINO_CMAKE_TOP_FOLDER}/Platform/Initialization/DefaultCFlags${PLATFORM_ARCHITECTURE_POSTFIX}.cmake)
#=============================================================================#
# setup_c_flags
# [PRIVATE/INTERNAL]
#
# setup_c_flags()
#
# Setups some basic flags for the gcc compiler to use later.
#=============================================================================#
function(setup_c_flags)
    if (NOT DEFINED ARDUINO_C_FLAGS)
        set(ARDUINO_C_FLAGS "${ARDUINO_DEFAULT_CFLAGS}"   CACHE INTERNAL "") 
    endif (NOT DEFINED ARDUINO_C_FLAGS)
    set(CMAKE_C_FLAGS "-g -Os       ${ARDUINO_C_FLAGS}" CACHE STRING "")
    set(CMAKE_C_FLAGS_DEBUG "-g  " CACHE STRING "")
    set(CMAKE_C_FLAGS_MINSIZEREL "-Os -DNDEBUG" CACHE STRING "")
    set(CMAKE_C_FLAGS_RELEASE "-Os -DNDEBUG -w " CACHE STRING "")
    set(CMAKE_C_FLAGS_RELWITHDEBINFO "-Os -g       -w " CACHE STRING "")
endfunction()

#=============================================================================#
#                             C++ Flags
#=============================================================================#
#=============================================================================#
# setup_c_flags
# [PRIVATE/INTERNAL]
#
# setup_cxx_flags()
#
# Setups some basic flags for the g++ compiler to use later.
#=============================================================================#
function(setup_cxx_flags)
    if (NOT DEFINED ARDUINO_CXX_FLAGS)
        IF(DEFINED ARDUINO_DEFAULT_CXXFLAGS)
            set(ARDUINO_CXX_FLAGS "${ARDUINO_DEFAULT_CXXFLAGS} " CACHE INTERNAL "")
        ELSE(DEFINED ARDUINO_DEFAULT_CXXFLAGS)
            set(ARDUINO_CXX_FLAGS "${ARDUINO_C_FLAGS} -fno-exceptions " CACHE INTERNAL "")
        ENDIF(DEFINED ARDUINO_DEFAULT_CXXFLAGS)
    endif (NOT DEFINED ARDUINO_CXX_FLAGS)
    set(CMAKE_CXX_FLAGS "-g -Os       ${ARDUINO_CXX_FLAGS}" CACHE STRING "")
    set(CMAKE_CXX_FLAGS_DEBUG "-g" CACHE STRING "")
    set(CMAKE_CXX_FLAGS_MINSIZEREL "-Os -DNDEBUG" CACHE STRING "")
    set(CMAKE_CXX_FLAGS_RELEASE "-Os -DNDEBUG " CACHE STRING "")
    set(CMAKE_CXX_FLAGS_RELWITHDEBINFO "-Os -g      " CACHE STRING "")
    #MESSAGE(STATUS "CXX FLAGS =${CMAKE_CXX_FLAGS}")
    #MESSAGE(STATUS "CMAKE_CXX_FLAGS_DEBUG FLAGS =${CMAKE_CXX_FLAGS_DEBUG}")
endfunction()

#=============================================================================#
#                       Executable Linker Flags                               #
#=============================================================================#
#=============================================================================#
# setup_exe_linker_flags
# [PRIVATE/INTERNAL]
#
# setup_exe_linker_flags()
#
# Setups some basic flags for the gcc linker to use when linking executables.
#=============================================================================#
function(setup_exe_linker_flags)
    if (NOT DEFINED ARDUINO_LINKER_FLAGS)
        set(ARDUINO_LINKER_FLAGS "-Wl,--gc-sections -lm")
    endif()
    set(CMAKE_EXE_LINKER_FLAGS "${ARDUINO_LINKER_FLAGS}" CACHE STRING "")
    set(CMAKE_EXE_LINKER_FLAGS_DEBUG "" CACHE STRING "")
    set(CMAKE_EXE_LINKER_FLAGS_MINSIZEREL "" CACHE STRING "")
    set(CMAKE_EXE_LINKER_FLAGS_RELEASE "" CACHE STRING "")
    set(CMAKE_EXE_LINKER_FLAGS_RELWITHDEBINFO "" CACHE STRING "")
endfunction()

#=============================================================================#
#                       Shared Library Linker Flags                           #
#=============================================================================#
#=============================================================================#
# setup_shared_lib_flags
# [PRIVATE/INTERNAL]
#
# setup_shared_lib_flags()
#
# Setups some basic flags for the gcc linker to use when linking shared libraries.
#=============================================================================#
function(setup_shared_lib_flags)
    set(CMAKE_SHARED_LINKER_FLAGS "${ARDUINO_LINKER_FLAGS}" CACHE STRING "")
    set(CMAKE_SHARED_LINKER_FLAGS_DEBUG "" CACHE STRING "")
    set(CMAKE_SHARED_LINKER_FLAGS_MINSIZEREL "" CACHE STRING "")
    set(CMAKE_SHARED_LINKER_FLAGS_RELEASE "" CACHE STRING "")
    set(CMAKE_SHARED_LINKER_FLAGS_RELWITHDEBINFO "" CACHE STRING "")

    set(CMAKE_MODULE_LINKER_FLAGS "${ARDUINO_LINKER_FLAGS}" CACHE STRING "")
    set(CMAKE_MODULE_LINKER_FLAGS_DEBUG "" CACHE STRING "")
    set(CMAKE_MODULE_LINKER_FLAGS_MINSIZEREL "" CACHE STRING "")
    set(CMAKE_MODULE_LINKER_FLAGS_RELEASE "" CACHE STRING "")
    set(CMAKE_MODULE_LINKER_FLAGS_RELWITHDEBINFO "" CACHE STRING "")
endfunction()

#=============================================================================#
# Setups some basic flags for the gcc/g++ compiler and linker.
#=============================================================================#
setup_c_flags()
setup_cxx_flags()
setup_exe_linker_flags()
setup_shared_lib_flags()
