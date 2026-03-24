cmake_minimum_required(VERSION 3.25...4.2)

project(iBASS-SDL VERSION 0.1.3 LANGUAGES CXX
  DESCRIPTION "Beneath A Steel Sky: Remastered (SDL)"
  HOMEPAGE_URL "")
set(PROJECT_BUGREPORT "")

set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)

# set build type to debug, if not set
if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE "Debug" CACHE STRING "Choose the type of build, options are: Debug Release RelWithDebInfo MinSizeRel." FORCE)
else()
  set(CMAKE_BUILD_TYPE ${CMAKE_BUILD_TYPE} CACHE STRING "Choose the type of build, options are: Debug Release RelWithDebInfo MinSizeRel.")
endif()
set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS "Debug" "Release" "MinSizeRel" "RelWithDebInfo")

# external libs
find_package(SDL2 REQUIRED)
find_package(SDL2_mixer REQUIRED)
find_package(ZLIB REQUIRED)

add_executable(sdlBASS
	common/file.cpp
	common/file.h
	common/pack-end.h
	common/pack-start.h
	common/scummsys.h
	common/system.h
	ext/cute_png.cpp
	ext/cute_png.h
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
	SDL2::SDL2 SDL2_mixer::SDL2_mixer ZLIB::ZLIB)

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
