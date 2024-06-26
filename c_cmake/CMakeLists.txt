# 動作確認できたCMakeのバージョン
cmake_minimum_required(VERSION 3.16.3)

# project情報
project(bowling_game
        DESCRIPTION "ボーリングのスコア計算 cliツール project"
        LANGUAGES C
)

# CTestを有効にする
enable_testing()

# コンパイル情報をJSON形式で出力
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# in-source ビルドガード
if(${CMAKE_SOURCE_DIR} STREQUAL ${CMAKE_BINARY_DIR})
    message(FATAL_ERROR "In-source builds not allowed. Please make a new directory (called a build directory) and run CMake from there. You may need to remove CMakeCache.txt. ")
endif()

# ビルドフォルダをgitの無視対象にする
file(WRITE ${CMAKE_BINARY_DIR}/.gitignore "*\n")

#################################################################################

include(FetchContent)

# Avoid warnings in CMake 3.24.0:
if (CMAKE_VERSION VERSION_GREATER "3.24.0")
    cmake_policy(SET CMP0135 NEW)
endif()

FetchContent_Declare(
    PCUnit
    URL https://github.com/steelpipe75/PCUnit/archive/da3364e1ec4b16a7659d2ed63900707922f7479e.zip
)
FetchContent_MakeAvailable(PCUnit)

#################################################################################

# message(STATUS "CMAKE_C_COMPILER_ID is ${CMAKE_C_COMPILER_ID}")
if(CMAKE_C_COMPILER_ID STREQUAL "Clang")
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
        PRIVATE $<$<C_COMPILER_ID:MSVC>:/W4 /WX- /utf-8>
        PRIVATE $<$<C_COMPILER_ID:Clang>:-Wall -Wextra>
        PRIVATE $<$<AND:$<C_COMPILER_ID:Clang>,$<CONFIG:Debug>>:-g -O0>
        PRIVATE $<$<AND:$<C_COMPILER_ID:Clang>,$<CONFIG:Release>>:-O3 -DNDEBUG>
        PRIVATE $<$<AND:$<C_COMPILER_ID:Clang>,$<CONFIG:Coverage>>:-g -O0 -fprofile-instr-generate -fcoverage-mapping>
    )
    if(${SW_OPT_no_unused_parameter})
        target_compile_options(${ARG_TARGET_NAME}
            PRIVATE $<$<AND:$<C_COMPILER_ID:Clang>>:-Wno-unused-parameter>
        )
    endif()
    target_link_options(${ARG_TARGET_NAME}
        PRIVATE $<$<AND:$<C_COMPILER_ID:Clang>,$<CONFIG:Coverage>>:-fprofile-instr-generate -fcoverage-mapping>
    )
endmacro()

#################################################################################

add_subdirectory(lib/bowling_game)

#################################################################################

add_executable(
    bowling_game_test
    lib/bowling_game/test/bowling_game_test.c
)
target_link_libraries(bowling_game_test PCUnit bowling_game_static)
target_compile_options_helper(bowling_game_test)

add_test(
    NAME bowling_game_test
    COMMAND $<TARGET_FILE:bowling_game_test>
)

#################################################################################

add_executable(
    bowling_game_cli
    src/bowling_game_cli.c
)
target_link_libraries(bowling_game_cli bowling_game_static)
target_compile_options_helper(bowling_game_cli)
