
MACRO(Log)
   MESSAGE(STATUS "Log: ${ARGN}")
ENDMACRO(Log)
#
#
#
FUNCTION(EXPORT_LIBRARY lib)    
    Log(${ARGN})
    cmake_parse_arguments(PARSE_ARGV 
                            1
                            "${lib}"
                            "" 
                            "NAME"
                            "FLAGS;INCLUDE_PATHS" 
                             )
    SET_PROPERTY(GLOBAL PROPERTY CMAKE_STM32_${lib}_FLAGS           ${${lib}_FLAGS}   )
    SET_PROPERTY(GLOBAL PROPERTY CMAKE_STM32_${lib}_INCLUDE_PATHS   ${${lib}_INCLUDE_PATHS}   )
    SET_PROPERTY(GLOBAL PROPERTY CMAKE_STM32_${lib}_NAME            ${${lib}_NAME}   )
    Log("SET Include for ${lib}: <${CMAKE_STM32_${lib}_INCLUDE_PATHS}> : < ${${lib}_INCLUDE_PATHS}>")
    Log("SET NAME for ${lib}: >${CMAKE_STM33_${lib}_NAME}> :  <${${lib}_NAME}>")
    set(unused "${${lib}_UNPARSED_ARGUMENTS}")
    IF("${unused}" STREQUAL "")
    ELSE("${unused}" STREQUAL "")
        MESSAGE(STATUS "Unparsed Arg ${${lib}_UNPARSED_ARGUMENTS}")
    ENDIF("${unused}" STREQUAL "")
ENDFUNCTION(EXPORT_LIBRARY lib)

#
#
#
MACRO(IMPORT_LIBRARY lib )
    GET_PROPERTY( ${lib}_FLAGS          GLOBAL PROPERTY      CMAKE_STM32_${lib}_FLAGS  )
    GET_PROPERTY( ${lib}_INCLUDE_PATHS  GLOBAL PROPERTY      CMAKE_STM32_${lib}_INCLUDE_PATHS )
   
    FOREACH(I ${${lib}_INCLUDE_PATHS} )
        Log("Get Include for ${lib} : <${I}>")
        include_directories( ${I} )
    ENDFOREACH(I ${${lib}_INCLUDE_PATHS} )
    add_definitions( ${${lib}_FLAGS}   )
    Log("Get FLAGS for ${lib} : <${${lib}_FLAGS}>")
ENDMACRO(IMPORT_LIBRARY lib)

#
#
#
FUNCTION(LINK_TO_LIBRARIES target )
    Log("Link to lib ${ARGN}")
    FOREACH(l ${ARGN})
             GET_PROPERTY( ${l}_NAME           GLOBAL PROPERTY      CMAKE_STM32_${l}_NAME  )
             TARGET_LINK_LIBRARIES(${target}  ${${l}_NAME})
             Log("Linking to ${${l}_NAME}")
    ENDFOREACH(l ${ARGN})
ENDFUNCTION(LINK_TO_LIBRARIES )
