include(FindPatch)

MACRO(APPLY_PATCH_IF_NEEDED markerFile patchFile description)
IF(NOT EXISTS "${PLATFORM_PATH}/${markerFile}")
    MESSAGE(STATUS "Patching file in ${PLATFORM_PATH} ${description}")
    patch_file_p(2 "${PLATFORM_PATH}" "${CMAKE_SOURCE_DIR}/patches/${patchFile}")
    file(WRITE "${PLATFORM_PATH}/${markerFile}" "patched")
ENDIF(NOT EXISTS "${PLATFORM_PATH}/${markerFile}")
ENDMACRO(APPLY_PATCH_IF_NEEDED markerFile patchFile description)


