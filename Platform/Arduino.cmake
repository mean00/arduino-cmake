#=============================================================================#
# Original Author: Tomasz Bogdal (QueezyTheGreat)
# Current Author: Timor Gruber (MrPointer)
# Original Home: https://github.com/queezythegreat/arduino-cmake
# Current Home: https://github.com/arduino-cmake/arduino-cmake
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this file,
# You can obtain one at http://mozilla.org/MPL/2.0/.
#=============================================================================#

cmake_minimum_required(VERSION 2.8.5)

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${ARDUINO_CMAKE_TOP_FOLDER}/Platform)
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${ARDUINO_CMAKE_TOP_FOLDER}/Platform/Initialization)
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${ARDUINO_CMAKE_TOP_FOLDER}/Platform/Core)
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${ARDUINO_CMAKE_TOP_FOLDER}/Platform/Core/BoardFlags)
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${ARDUINO_CMAKE_TOP_FOLDER}/Platform/Core/Libraries)
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${ARDUINO_CMAKE_TOP_FOLDER}/Platform/Core/Targets)
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${ARDUINO_CMAKE_TOP_FOLDER}/Platform/Core/Sketch)
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${ARDUINO_CMAKE_TOP_FOLDER}/Platform/Core/Examples)
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${ARDUINO_CMAKE_TOP_FOLDER}/Platform/Extras)
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${ARDUINO_CMAKE_TOP_FOLDER}/Platform/Generation)

include(CMakeParseArguments)

include(VariableValidator)
include(Initializer)

include(Macros)
include(BoardPropertiesReader)
include(FlagsSetter)
include(SourceFinder)
include(LibraryFinder)
include(DebugOptions)
include(Printer)
include(GeneratorSettingsLoader)

include(ArduinoSketchToCppConverter)
include(ArduinoSketchFactory)

include(CoreLibraryFactory)
include(ArduinoLibraryFactory)
include(BlacklistedLibrariesRemover)

include(ArduinoExampleFactory)
include(ArduinoLibraryExampleFactory)

include(ArduinoBootloaderArgumentsBuilder)
include(ArduinoBootloaderBurnTargetCreator)
include(ArduinoBootloaderUploadTargetCreator)
include(ArduinoFirmwareTargetCreator)
include(ArduinoProgrammerArgumentsBuilder)
include(ArduinoProgrammerBurnTargetCreator)
include(ArduinoSerialTargetCreator)
include(ArduinoUploadTargetCreator)

include(AvrLibraryGenerator)
include(AvrFirmwareGenerator)
include(ArduinoLibraryGenerator)
include(ArduinoFirmwareGenerator)
include(ArduinoExampleGenerator)
include(ArduinoLibraryExampleGenerator)
# Mean00 : Needs to be included every time ????
include(SetupRecursiveLibraries)

if (IS_SCRIPT_PROCESSED)
    return()
endif ()

# Setup libraries known to be recursive only once

set(IS_SCRIPT_PROCESSED True CACHE BOOL
        "Indicates whether platform script has already been processed")
