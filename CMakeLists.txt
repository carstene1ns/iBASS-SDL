cmake_minimum_required(VERSION 3.22...4.3 FATAL_ERROR)

project(iBASS-SDL VERSION 0.2.1 LANGUAGES CXX
	DESCRIPTION "Beneath A Steel Sky: Remastered (SDL)"
	HOMEPAGE_URL "")
set(PROJECT_BUGREPORT "https://github.com/carstene1ns/iBASS-SDL/issues")

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# set build type to debug, if not set
if(NOT CMAKE_BUILD_TYPE)
	set(CMAKE_BUILD_TYPE "Debug" CACHE STRING "Choose the type of build, options are: Debug Release RelWithDebInfo MinSizeRel." FORCE)
else()
	set(CMAKE_BUILD_TYPE ${CMAKE_BUILD_TYPE} CACHE STRING "Choose the type of build, options are: Debug Release RelWithDebInfo MinSizeRel.")
endif()
set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS "Debug" "Release" "MinSizeRel" "RelWithDebInfo")

# external libs
find_package(SDL2 2.0.18 REQUIRED)
find_package(SDL2_mixer REQUIRED)
find_package(ZLIB REQUIRED)

include(FetchContent)
set(TGUI_BACKEND "SDL_RENDERER")
set(TGUI_USE_SDL3 FALSE) # sdl2
set(TGUI_BUILD_GUI_BUILDER OFF)
FetchContent_Declare(TGUI
	URL https://github.com/texus/TGUI/archive/v1.12.0.zip
	URL_HASH SHA256=73aafbdb186a41e80376de1baf185840207621f975316d83b20dd458e21cd57b)
FetchContent_MakeAvailable(TGUI)

add_library(external STATIC
	ext/cute_png.cpp
	ext/cute_png.h
	ext/scope_guard.hpp)
target_include_directories(external INTERFACE ext)

add_executable(sdlBASS
	src/common/file.cpp
	src/common/file.h
	src/common/pack-end.h
	src/common/pack-start.h
	src/common/scummsys.h
	src/common/system.h
	src/gui/asciiData.cpp
	src/gui/asciiData.h
	src/gui/panel.h
	src/gui/panelMan.cpp
	src/gui/panelMan.h
	src/gui/panels/audio.cpp
	src/gui/panels/audio.h
	src/gui/panels/control.cpp
	src/gui/panels/control.h
	src/gui/panels/death.cpp
	src/gui/panels/death.h
	src/gui/panels/language.cpp
	src/gui/panels/language.h
	src/gui/panels/load.cpp
	src/gui/panels/load.h
	src/gui/panels/save.cpp
	src/gui/panels/save.h
	src/gui/panels/start.cpp
	src/gui/panels/start.h
	src/iBASS_fake.cpp
	src/main.cpp
	src/sky/autoroute.cpp
	src/sky/autoroute.h
	src/sky/compact.cpp
	src/sky/compact.h
	src/sky/disk.cpp
	src/sky/disk.h
	src/sky/grid.cpp
	src/sky/grid.h
	src/sky/hufftext.cpp
	src/sky/logic.cpp
	src/sky/logic.h
	src/sky/mouse.cpp
	src/sky/mouse.h
	src/sky/music.cpp
	src/sky/music.h
	src/sky/saveload.cpp
	src/sky/saveload.h
	src/sky/screen.cpp
	src/sky/screen.h
	src/sky/sky.cpp
	src/sky/sky.h
	src/sky/skydefs.h
	src/sky/sound.cpp
	src/sky/sound.h
	src/sky/struc.h
	src/sky/text.cpp
	src/sky/text.h
	src/system/caffile.cpp
	src/system/common.cpp
	src/system/common.h
	src/system/ima4.cpp
	src/system/othsys.h
	src/system/othsys_sdl.cpp
	src/system/othsys_sdl.h
	src/system/random.cpp
	src/system/random.h
	src/system/savefile.cpp
	src/system/savefile.h
	src/system/types.h)
target_include_directories(sdlBASS PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/src)
target_compile_definitions(sdlBASS PRIVATE $<$<CONFIG:Debug>:DEBUG>)
target_compile_options(sdlBASS PRIVATE -Wall) # -Wextra

target_link_libraries(sdlBASS PRIVATE
	SDL2::SDL2 SDL2_mixer::SDL2_mixer external ZLIB::ZLIB TGUI::TGUI)

if(UNIX)
	target_link_libraries(sdlBASS PRIVATE -lm)
	if (CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
		target_compile_options(sdlBASS PRIVATE "-fno-math-errno")
	endif()
endif()

option(WANT_ASAN "build with address sanitizer" OFF)
if(WANT_ASAN)
	message(STATUS "Building with address sanitizer")
	target_compile_options(sdlBASS PRIVATE -fno-omit-frame-pointer -fsanitize=address)
	target_link_options(sdlBASS PRIVATE -fno-omit-frame-pointer -fsanitize=address)
endif()
