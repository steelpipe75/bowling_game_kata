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

set(default_build_type "Debug")
if(NOT CMAKE_BUILD_TYPE)
    message(STATUS "Setting build type to '${default_build_type}' as none was specified.")
    set(CMAKE_BUILD_TYPE "${default_build_type}" CACHE
        STRING "Choose the type of build." FORCE)
    set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS
        "Debug" "Release" "Coverage")
endif()

set(CMAKE_C_FLAGS "-Wall -Wextra")
set(CMAKE_C_FLAGS_DEBUG "-g -O0")
set(CMAKE_C_FLAGS_RELEASE "-O3 -DNDEBUG")
set(CMAKE_C_FLAGS_COVERAGE "-g -O0 -fprofile-instr-generate -fcoverage-mapping")

if(CMAKE_BUILD_TYPE STREQUAL "Coverage")
    configure_file(utility/coverage_test_luncher.bat.in coverage_test_luncher.bat COPYONLY)
    set(TEST_LUNCHER "coverage_test_luncher.bat")
    set(POST_TEST_PROCESS "call coverage_post_test_process.bat")
    configure_file(utility/coverage_post_test_process.bat.in coverage_post_test_process.bat COPYONLY)
else()
    configure_file(utility/test_luncher.bat.in test_luncher.bat COPYONLY)
    set(TEST_LUNCHER "test_luncher.bat")
    unset(POST_TEST_PROCESS)
endif()


include_directories(lib/bowling_game/src)

add_executable(
    bowling_game_test
    lib/bowling_game/src/bowling_game.c
    lib/bowling_game/test/bowling_game_test.c
)

add_test(
    NAME bowling_game_test
    COMMAND ${TEST_LUNCHER} bowling_game_test $<TARGET_FILE:bowling_game_test>
)

add_executable(
    bowling_game_cli
    lib/bowling_game/src/bowling_game.c
    src/bowling_game_cli.c
)

macro(do_cli_test testname inputfile output)
    add_test(
        NAME bowling_game_cli_test_${testname}
        COMMAND ${TEST_LUNCHER} bowling_game_cli_test_${testname} $<TARGET_FILE:bowling_game_cli> ${inputfile}
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

file(WRITE ${CMAKE_BINARY_DIR}/config.bat "@echo off
cd /D %~dp0
cmake . %*
cmd /K
")

file(WRITE ${CMAKE_BINARY_DIR}/config-gui.bat "cd /D %~dp0
start cmake-gui . %*
")

# ビルドとテストを実行するバッチ
configure_file(utility/build_and_test.bat.in build_and_test.bat)
