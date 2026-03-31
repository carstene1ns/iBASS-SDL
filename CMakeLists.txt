cmake_minimum_required(VERSION 3.22...4.3 FATAL_ERROR)

project(iBASS-SDL VERSION 0.2.0 LANGUAGES CXX
	DESCRIPTION "Beneath A Steel Sky: Remastered (SDL)"
	HOMEPAGE_URL "")
set(PROJECT_BUGREPORT "https://github.com/carstene1ns/iBASS-SDL/issues")

set(CMAKE_C_STANDARD 14)
set(CMAKE_C_STANDARD_REQUIRED ON)

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
	common/file.cpp
	common/file.h
	common/pack-end.h
	common/pack-start.h
	common/scummsys.h
	common/system.h
	gui/asciiData.cpp
	gui/asciiData.h
	gui/panel.h
	gui/panelMan.cpp
	gui/panelMan.h
	gui/panels/audio.cpp
	gui/panels/audio.h
	gui/panels/control.cpp
	gui/panels/control.h
	gui/panels/death.cpp
	gui/panels/death.h
	gui/panels/language.cpp
	gui/panels/language.h
	gui/panels/load.cpp
	gui/panels/load.h
	gui/panels/save.cpp
	gui/panels/save.h
	gui/panels/start.cpp
	gui/panels/start.h
	iBASS_fake.cpp
	main.cpp
	sky/autoroute.cpp
	sky/autoroute.h
	sky/compact.cpp
	sky/compact.h
	sky/disk.cpp
	sky/disk.h
	sky/grid.cpp
	sky/grid.h
	sky/hufftext.cpp
	sky/inventory.cpp
	sky/logic.cpp
	sky/logic.h
	sky/mouse.cpp
	sky/mouse.h
	sky/music.cpp
	sky/music.h
	sky/saveload.cpp
	sky/saveload.h
	sky/screen.cpp
	sky/screen.h
	sky/sky.cpp
	sky/sky.h
	sky/skydefs.h
	sky/sound.cpp
	sky/sound.h
	sky/struc.h
	sky/text.cpp
	sky/text.h
	system/caffile.cpp
	system/common.cpp
	system/common.h
	system/ima4.cpp
	system/othsys.h
	system/othsys_sdl.cpp
	system/othsys_sdl.h
	system/random.cpp
	system/random.h
	system/savefile.cpp
	system/savefile.h
	system/types.h)
target_include_directories(sdlBASS PRIVATE ${CMAKE_CURRENT_SOURCE_DIR})
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
