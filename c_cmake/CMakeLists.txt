# 動作確認できたCMakeのバージョン
cmake_minimum_required(VERSION 3.16)

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

#################################################################################

include(FetchContent)

# Avoid warnings in CMake 3.24.0:
if (CMAKE_VERSION VERSION_GREATER "3.24.0")
    cmake_policy(SET CMP0135 NEW)
endif()

FetchContent_Declare(
    PCUnit
    URL https://github.com/steelpipe75/PCUnit/archive/4ad20e36ae9df8739ed8e1cf3f4f1fa593f6d8db.zip
)
FetchContent_MakeAvailable(PCUnit)

#################################################################################

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

if(WIN32)
    if(CMAKE_BUILD_TYPE STREQUAL "Coverage")
        configure_file(../utility/coverage_test_luncher.bat.in coverage_test_luncher.bat COPYONLY)
        set(TEST_LUNCHER "coverage_test_luncher.bat")
        set(POST_TEST_PROCESS "call coverage_post_test_process.bat")
        configure_file(../utility/coverage_post_test_process.bat.in coverage_post_test_process.bat COPYONLY)
    elseif(CMAKE_BUILD_TYPE STREQUAL "Debug")
        configure_file(./utility/launch.json.c.in ${CMAKE_BINARY_DIR}/../.vscode/launch.json COPYONLY)
        
        configure_file(../utility/test_luncher.bat.in test_luncher.bat COPYONLY)
        set(TEST_LUNCHER "test_luncher.bat")
        unset(POST_TEST_PROCESS)
    else()
        configure_file(../utility/test_luncher.bat.in test_luncher.bat COPYONLY)
        set(TEST_LUNCHER "test_luncher.bat")
        unset(POST_TEST_PROCESS)
    endif()
elseif(UNIX)
    if(CMAKE_BUILD_TYPE STREQUAL "Coverage")
        configure_file(../utility/coverage_test_luncher.sh.in coverage_test_luncher.sh COPYONLY)
        set(TEST_LUNCHER "coverage_test_luncher.sh")
        set(POST_TEST_PROCESS "call coverage_post_test_process.sh")
        configure_file(../utility/coverage_post_test_process.sh.in coverage_post_test_process.sh COPYONLY)
    elseif(CMAKE_BUILD_TYPE STREQUAL "Debug")
        # configure_file(./utility/launch.json.c.in ${CMAKE_BINARY_DIR}/../.vscode/launch.json COPYONLY)

        configure_file(../utility/test_luncher.sh.in test_luncher.sh COPYONLY)
        set(TEST_LUNCHER "test_luncher.sh")
        unset(POST_TEST_PROCESS)
    else()
        configure_file(../utility/test_luncher.sh.in test_luncher.sh COPYONLY)
        set(TEST_LUNCHER "test_luncher.sh")
        unset(POST_TEST_PROCESS)
    endif()
endif()


include_directories(lib/bowling_game/src)

#################################################################################

add_executable(
    bowling_game_test_assert
    lib/bowling_game/src/bowling_game.c
    lib/bowling_game/test/assert/bowling_game_test_assert.c
)

if(WIN32)
    add_test(
        NAME bowling_game_test_assert
        COMMAND ${TEST_LUNCHER} bowling_game_test_assert $<TARGET_FILE:bowling_game_test_assert>
    )
elseif(UNIX)
    add_test(
        NAME bowling_game_test_assert
        COMMAND sh ${TEST_LUNCHER} bowling_game_test_assert $<TARGET_FILE:bowling_game_test_assert>
    )
endif()

#################################################################################

add_executable(
    bowling_game_test_pcunit
    lib/bowling_game/src/bowling_game.c
    lib/bowling_game/test/pcunit/bowling_game_test_pcunit.c
)

target_link_libraries(bowling_game_test_pcunit PCUnit)

target_include_directories(bowling_game_test_pcunit PUBLIC ${CMAKE_BINARY_DIR}/_deps/pcunit-src)


if(WIN32)
    add_test(
        NAME bowling_game_test_pcunit
        COMMAND ${TEST_LUNCHER} bowling_game_test_pcunit $<TARGET_FILE:bowling_game_test_pcunit>
    )
elseif(UNIX)
    add_test(
        NAME bowling_game_test_pcunit
        COMMAND sh ${TEST_LUNCHER} bowling_game_test_pcunit $<TARGET_FILE:bowling_game_test_pcunit>
    )
endif()

#################################################################################

add_executable(
    bowling_game_cli
    lib/bowling_game/src/bowling_game.c
    src/bowling_game_cli.c
)

macro(do_cli_test testname inputfile output)
    if(WIN32)
        add_test(
            NAME bowling_game_cli_test_${testname}
            COMMAND ${TEST_LUNCHER} bowling_game_cli_test_${testname} $<TARGET_FILE:bowling_game_cli> ${inputfile}
            WORKING_DIRECTORY ${CMAKE_BAIBARY_DIR}
        )
    elseif(UNIX)
        add_test(
            NAME bowling_game_cli_test_${testname}
            COMMAND sh ${TEST_LUNCHER} bowling_game_cli_test_${testname} $<TARGET_FILE:bowling_game_cli> ${inputfile}
            WORKING_DIRECTORY ${CMAKE_BAIBARY_DIR}
        )
    endif()
    set_tests_properties(
        bowling_game_cli_test_${testname} PROPERTIES
        PASS_REGULAR_EXPRESSION ${output}
    )
endmacro()

do_cli_test(
    all_ones
    ../../testdata/all_ones.txt
    20
)

do_cli_test(
    gutter_game
    ../../testdata/gutter_game.txt
    0
)

do_cli_test(
    one_spare
    ../../testdata/one_spare.txt
    16
)

do_cli_test(
    one_strike
    ../../testdata/one_strike.txt
    24
)

do_cli_test(
    perfect_game
    ../../testdata/perfect_game.txt
    300
)

do_cli_test(
    no_inputfile
    ""
    "usage: $<TARGET_FILE:bowling_game_cli> inputfilename"
)

do_cli_test(
    cant_open_inputfile
    ../../testdata/cant_open_inputfile.txt
    "can't open ../../testdata/cant_open_inputfile.txt"
)

#################################################################################

add_library(
    bowling_game_share
    SHARED
    lib/bowling_game/src/bowling_game.c
)

add_executable(
    bowling_game_cli_shared
    src/bowling_game_cli.c
)

target_link_libraries(bowling_game_cli_shared bowling_game_share)

macro(do_cli_shared_test testname inputfile output)
    if(WIN32)
        add_test(
            NAME bowling_game_cli_shared_test_${testname}
            COMMAND ${TEST_LUNCHER} bowling_game_cli_shared_test_${testname} $<TARGET_FILE:bowling_game_cli_shared> ${inputfile}
            WORKING_DIRECTORY ${CMAKE_BAIBARY_DIR}
        )
    elseif(UNIX)
        add_test(
            NAME bowling_game_cli_shared_test_${testname}
            COMMAND sh ${TEST_LUNCHER} bowling_game_cli_shared_test_${testname} $<TARGET_FILE:bowling_game_cli_shared> ${inputfile}
            WORKING_DIRECTORY ${CMAKE_BAIBARY_DIR}
        )
    endif()
    set_tests_properties(
        bowling_game_cli_shared_test_${testname} PROPERTIES
        PASS_REGULAR_EXPRESSION ${output}
    )
endmacro()

do_cli_shared_test(
    all_ones
    ../../testdata/all_ones.txt
    20
)

do_cli_shared_test(
    gutter_game
    ../../testdata/gutter_game.txt
    0
)

do_cli_shared_test(
    one_spare
    ../../testdata/one_spare.txt
    16
)

do_cli_shared_test(
    one_strike
    ../../testdata/one_strike.txt
    24
)

do_cli_shared_test(
    perfect_game
    ../../testdata/perfect_game.txt
    300
)

do_cli_shared_test(
    no_inputfile
    ""
    "usage: $<TARGET_FILE:bowling_game_cli_shared> inputfilename"
)

do_cli_shared_test(
    cant_open_inputfile
    ../../testdata/cant_open_inputfile.txt
    "can't open ../../testdata/cant_open_inputfile.txt"
)

#################################################################################

add_library(
    bowling_game_static
    STATIC
    lib/bowling_game/src/bowling_game.c
)

add_executable(
    bowling_game_cli_static
    src/bowling_game_cli.c
)

target_link_libraries(bowling_game_cli_static bowling_game_static)

macro(do_cli_static_test testname inputfile output)
    if(WIN32)
        add_test(
            NAME bowling_game_cli_static_test_${testname}
            COMMAND ${TEST_LUNCHER} bowling_game_cli_static_test_${testname} $<TARGET_FILE:bowling_game_cli_static> ${inputfile}
            WORKING_DIRECTORY ${CMAKE_BAIBARY_DIR}
        )
    elseif(UNIX)
        add_test(
            NAME bowling_game_cli_static_test_${testname}
            COMMAND sh ${TEST_LUNCHER} bowling_game_cli_static_test_${testname} $<TARGET_FILE:bowling_game_cli_static> ${inputfile}
            WORKING_DIRECTORY ${CMAKE_BAIBARY_DIR}
        )
    endif()
    set_tests_properties(
        bowling_game_cli_static_test_${testname} PROPERTIES
        PASS_REGULAR_EXPRESSION ${output}
    )
endmacro()

do_cli_static_test(
    all_ones
    ../../testdata/all_ones.txt
    20
)

do_cli_static_test(
    gutter_game
    ../../testdata/gutter_game.txt
    0
)

do_cli_static_test(
    one_spare
    ../../testdata/one_spare.txt
    16
)

do_cli_static_test(
    one_strike
    ../../testdata/one_strike.txt
    24
)

do_cli_static_test(
    perfect_game
    ../../testdata/perfect_game.txt
    300
)

do_cli_static_test(
    no_inputfile
    ""
    "usage: $<TARGET_FILE:bowling_game_cli_static> inputfilename"
)

do_cli_static_test(
    cant_open_inputfile
    ../../testdata/cant_open_inputfile.txt
    "can't open ../../testdata/cant_open_inputfile.txt"
)

#################################################################################

if(WIN32)

file(WRITE ${CMAKE_BINARY_DIR}/config.bat "@echo off
cd /D %~dp0
cmake . %*
cmd /K
")

file(WRITE ${CMAKE_BINARY_DIR}/config-gui.bat "cd /D %~dp0
start cmake-gui . %*
")

file(WRITE ${CMAKE_BINARY_DIR}/ninja_-t_deps.bat "cd /D %~dp0
ninja -t deps %*
")

# ビルドとテストを実行するバッチ
configure_file(../utility/build_and_test.bat.in build_and_test.bat)

elseif(UNIX)

endif()
