# 動作確認できたCMakeのバージョン
cmake_minimum_required(VERSION 3.16.3)

# project情報
project(bowling_game
        DESCRIPTION "ボーリングのスコア計算 cliツール project"
        LANGUAGES CXX
)

# CTestを有効にする
enable_testing()

# コンパイル情報をJSON形式で出力
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# in-source ビルドガード
if(${CMAKE_SOURCE_DIR} STREQUAL ${CMAKE_BINARY_DIR})
    message(FATAL_ERROR "In-source builds not allowed. Please make a new directory (called a build directory) and run CMake from there. You may need to remove CMakeCache.txt. ")
endif()

#################################################################################

include(FetchContent)

# Avoid warnings in CMake 3.24.0:
if (CMAKE_VERSION VERSION_GREATER "3.24.0")
    cmake_policy(SET CMP0135 NEW)
endif()

if("$ENV{GOOGLETEST_PATH}" STREQUAL "")
    set(gtest_url https://github.com/google/googletest/archive/refs/tags/release-1.12.1.zip)
    message(NOTICE "googletest download ${gtest_url}")
    FetchContent_Declare(
        googletest
        URL ${gtest_url}
    )
else()
    file(TO_CMAKE_PATH $ENV{GOOGLETEST_PATH} GOOGLETEST_CMAKE_PATH)

    message(NOTICE "googletest using file://${GOOGLETEST_CMAKE_PATH}")
    FetchContent_Declare(
        googletest
        URL file://${GOOGLETEST_CMAKE_PATH}
    )
endif()

# For Windows: Prevent overriding the parent project's compiler/linker settings
set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)
FetchContent_MakeAvailable(googletest)

include(GoogleTest)

#################################################################################

# message(STATUS "CMAKE_CXX_COMPILER_ID is ${CMAKE_CXX_COMPILER_ID}")
if(CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
    set(default_build_type "Coverage")
else()
    set(default_build_type "Debug")
endif()
if(NOT CMAKE_BUILD_TYPE)
    message(STATUS "Setting build type to '${default_build_type}' as none was specified.")
    set(CMAKE_BUILD_TYPE "${default_build_type}" CACHE
        STRING "Choose the type of build." FORCE)
    set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS
        "Debug" "Release" "Coverage")
endif()

option(SW_OPT_no_unused_parameter OFF "if \"ON\" add compile option \"-Wno-unused-parameter\"")

macro(target_compile_options_helper ARG_TARGET_NAME)
    target_compile_options(${ARG_TARGET_NAME}
        PRIVATE $<$<CXX_COMPILER_ID:MSVC>:/W4 /WX- /utf-8>
        PRIVATE $<$<CXX_COMPILER_ID:Clang>:-Wall -Wextra>
        PRIVATE $<$<AND:$<CXX_COMPILER_ID:Clang>,$<CONFIG:Debug>>:-g -O0>
        PRIVATE $<$<AND:$<CXX_COMPILER_ID:Clang>,$<CONFIG:Release>>:-O3 -DNDEBUG>
        PRIVATE $<$<AND:$<CXX_COMPILER_ID:Clang>,$<CONFIG:Coverage>>:-g -O0 -fprofile-instr-generate -fcoverage-mapping>
    )
    if(${SW_OPT_no_unused_parameter})
        target_compile_options(${ARG_TARGET_NAME}
            PRIVATE $<$<AND:$<CXX_COMPILER_ID:Clang>>:-Wno-unused-parameter>
        )
    endif()
    target_link_options(${ARG_TARGET_NAME}
        PRIVATE $<$<AND:$<CXX_COMPILER_ID:Clang>,$<CONFIG:Coverage>>:-fprofile-instr-generate -fcoverage-mapping>
    )
endmacro()

#################################################################################

add_subdirectory(lib/bowling_game)

#################################################################################

add_executable(
    bowling_game_test_gtest
    lib/bowling_game/src/bowling_game.cpp
    lib/bowling_game/test/gtest/bowling_game_test_gtest.cpp
)

target_link_libraries(bowling_game_test_gtest gtest_main)

if(WIN32)
    add_test(
        NAME bowling_game_test_gtest_All
        COMMAND ${TEST_LUNCHER} bowling_game_test_gtest $<TARGET_FILE:bowling_game_test_gtest>
    )
elseif(UNIX)
    add_test(
        NAME bowling_game_test_gtest_All
        COMMAND sh ${TEST_LUNCHER} bowling_game_test_gtest $<TARGET_FILE:bowling_game_test_gtest>
    )
endif()

target_include_directories(bowling_game_test_gtest
    PRIVATE lib/bowling_game/src
)
target_compile_options_helper(bowling_game_test_gtest)

add_custom_command(
  TARGET bowling_game_test_gtest POST_BUILD
  COMMAND ${CMAKE_COMMAND} -E copy $<TARGET_FILE:bowling_game_test_gtest> ${CMAKE_BINARY_DIR}
)

gtest_discover_tests(bowling_game_test_gtest)

#################################################################################

add_executable(
    bowling_game_cli
    lib/bowling_game/src/bowling_game.cpp
    src/bowling_game_cli.cpp
)

target_include_directories(bowling_game_cli
    PRIVATE lib/bowling_game/src
)
target_compile_options_helper(bowling_game_cli)
