# 動作確認できたCMakeのバージョン
cmake_minimum_required(VERSION 3.25)

# project情報
project(bowling_game
        DESCRIPTION "ボーリングのスコア計算 project"
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

SET_PROPERTY(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS "Debug" "Release")
if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE "Debug")
endif()

set(CMAKE_C_FLAGS "-Wall -Wextra")
set(CMAKE_C_FLAGS_DEBUG "-g -O0")
set(CMAKE_C_FLAGS_RELEASE "-O3 -DNDEBUG")

include_directories(lib/bowling_game/src)

add_executable(
    bowling_game_test
    lib/bowling_game/src/bowling_game.c
    lib/bowling_game/test/bowling_game_test.c
)

add_test(
    NAME bowling_game_test
    COMMAND bowling_game_test.exe
)

add_executable(
    bowling_game_cli
    lib/bowling_game/src/bowling_game.c
    src/bowling_game_cli.c
)

macro(do_cli_test testname inputfile output)
    add_test(
        NAME bowling_game_cli_test_${testname}
        COMMAND $<TARGET_FILE:bowling_game_cli> ${inputfile}
        WORKING_DIRECTORY ${CMAKE_BAIBARY_DIR}
    )
    set_tests_properties(
        bowling_game_cli_test_${testname} PROPERTIES
        PASS_REGULAR_EXPRESSION ${output}
    )
endmacro()

do_cli_test(
    all_ones
    ../data/testdata_all_ones.txt
    20
)

do_cli_test(
    gutter_game
    ../data/testdata_gutter_game.txt
    0
)

do_cli_test(
    one_spare
    ../data/testdata_one_spare.txt
    16
)

do_cli_test(
    one_strike
    ../data/testdata_one_strike.txt
    24
)

do_cli_test(
    perfect_game
    ../data/testdata_perfect_game.txt
    300
)

do_cli_test(
    no_inputfile
    ""
    "usage: $<TARGET_FILE:bowling_game_cli> inputfilename"
)

do_cli_test(
    cant_open_inputfile
    ../data/testdata_cant_open_inputfile.txt
    "can't open ../data/testdata_cant_open_inputfile.txt"
)

configure_file(build_and_run.bat.in build_and_run.bat COPYONLY)
