# 動作確認できたCMakeのバージョン
cmake_minimum_required(VERSION 3.22.1)

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

if(WIN32)
    if(CMAKE_C_COMPILER_ID STREQUAL "Clang")
        configure_file(./utility/launch.json.c.in ${CMAKE_BINARY_DIR}/.vscode/launch.json COPYONLY)
    endif()

    if(CMAKE_BUILD_TYPE STREQUAL "Coverage")
        configure_file(../utility/coverage_test_luncher.bat.in coverage_test_luncher.bat COPYONLY)
        set(TEST_LUNCHER "coverage_test_luncher.bat")
        set(POST_TEST_PROCESS "call coverage_post_test_process_common.bat")
        configure_file(../utility/coverage_post_test_process_common.bat.in coverage_post_test_process_common.bat COPYONLY)
    elseif(CMAKE_BUILD_TYPE STREQUAL "Debug")
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
        set(POST_TEST_PROCESS "call coverage_post_test_process_common.sh")
        configure_file(../utility/coverage_post_test_process_common.sh.in coverage_post_test_process_common.sh COPYONLY)
    elseif(CMAKE_BUILD_TYPE STREQUAL "Debug")
        # configure_file(./utility/launch.json.c.in ${CMAKE_BINARY_DIR}/.vscode/launch.json COPYONLY)

        configure_file(../utility/test_luncher.sh.in test_luncher.sh COPYONLY)
        set(TEST_LUNCHER "test_luncher.sh")
        unset(POST_TEST_PROCESS)
    else()
        configure_file(../utility/test_luncher.sh.in test_luncher.sh COPYONLY)
        set(TEST_LUNCHER "test_luncher.sh")
        unset(POST_TEST_PROCESS)
    endif()
endif()

#################################################################################

add_subdirectory(lib/bowling_game)

#################################################################################

include_directories(lib/bowling_game/src)

#################################################################################

add_executable(bowling_game_test_assert
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

target_include_directories(bowling_game_test_assert
    PRIVATE lib/bowling_game/src
)
target_compile_options_helper(bowling_game_test_assert)

add_custom_command(
  TARGET bowling_game_test_assert POST_BUILD
  COMMAND ${CMAKE_COMMAND} -E copy $<TARGET_FILE:bowling_game_test_assert> ${CMAKE_BINARY_DIR}
)

#################################################################################

add_executable(
    bowling_game_test_pcunit
    lib/bowling_game/src/bowling_game.c
    lib/bowling_game/test/pcunit/bowling_game_test_pcunit.c
)

target_link_libraries(bowling_game_test_pcunit PCUnit)

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

target_include_directories(bowling_game_test_pcunit
    PRIVATE lib/bowling_game/src
    PRIVATE ${CMAKE_BINARY_DIR}/_deps/pcunit-src
)
target_compile_options_helper(bowling_game_test_pcunit)

add_custom_command(
  TARGET bowling_game_test_pcunit POST_BUILD
  COMMAND ${CMAKE_COMMAND} -E copy $<TARGET_FILE:bowling_game_test_pcunit> ${CMAKE_BINARY_DIR}
)

#################################################################################

macro(find_test_data testfile variable)
    find_file(${variable}
        ${testfile}
        HINTS "${CMAKE_SOURCE_DIR}/../testdata/"
        REQUIRED
    )
endmacro()

find_test_data(all_ones.txt             input_file_path_all_one_test        )
find_test_data(all_zeros.txt            input_file_path_all_zeros           )
find_test_data(one_spare.txt            input_file_path_one_spare           )
find_test_data(one_strike.txt           input_file_path_one_strike          )
find_test_data(perfect_game.txt         input_file_path_perfect_game        )

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
            WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
        )
    elseif(UNIX)
        add_test(
            NAME bowling_game_cli_test_${testname}
            COMMAND sh ${TEST_LUNCHER} bowling_game_cli_test_${testname} $<TARGET_FILE:bowling_game_cli> ${inputfile}
            WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
        )
    endif()
    set_tests_properties(
        bowling_game_cli_test_${testname} PROPERTIES
        PASS_REGULAR_EXPRESSION ${output}
    )
endmacro()

target_include_directories(bowling_game_cli
    PRIVATE lib/bowling_game/src
)
target_compile_options_helper(bowling_game_cli)

add_custom_command(
  TARGET bowling_game_cli POST_BUILD
  COMMAND ${CMAKE_COMMAND} -E copy $<TARGET_FILE:bowling_game_cli> ${CMAKE_BINARY_DIR}
)

do_cli_test(
    all_ones
    ${input_file_path_all_one_test}
    20
)

do_cli_test(
    all_zeros
    ${input_file_path_all_zeros}
    0
)

do_cli_test(
    one_spare
    ${input_file_path_one_spare}
    16
)

do_cli_test(
    one_strike
    ${input_file_path_one_strike}
    24
)

do_cli_test(
    perfect_game
    ${input_file_path_perfect_game}
    300
)

do_cli_test(
    no_inputfile
    ""
    "usage: $<TARGET_FILE:bowling_game_cli> inputfilename"
)

do_cli_test(
    cant_open_inputfile
    cant_open_inputfile.txt
    "can't open cant_open_inputfile.txt"
)

#################################################################################

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
            WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
        )
    elseif(UNIX)
        add_test(
            NAME bowling_game_cli_shared_test_${testname}
            COMMAND sh ${TEST_LUNCHER} bowling_game_cli_shared_test_${testname} $<TARGET_FILE:bowling_game_cli_shared> ${inputfile}
            WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
        )
    endif()
    set_tests_properties(
        bowling_game_cli_shared_test_${testname} PROPERTIES
        PASS_REGULAR_EXPRESSION ${output}
    )
endmacro()

target_include_directories(bowling_game_cli_shared
    PRIVATE lib/bowling_game/src
)
target_compile_options_helper(bowling_game_cli_shared)

add_custom_command(
  TARGET bowling_game_cli_shared POST_BUILD
  COMMAND ${CMAKE_COMMAND} -E copy $<TARGET_FILE:bowling_game_share> ${CMAKE_BINARY_DIR}
  COMMAND ${CMAKE_COMMAND} -E copy $<TARGET_FILE:bowling_game_cli_shared> ${CMAKE_BINARY_DIR}
)

do_cli_shared_test(
    all_ones
    ${input_file_path_all_one_test}
    20
)

do_cli_shared_test(
    all_zeros
    ${input_file_path_all_zeros}
    0
)

do_cli_shared_test(
    one_spare
    ${input_file_path_one_spare}
    16
)

do_cli_shared_test(
    one_strike
    ${input_file_path_one_strike}
    24
)

do_cli_shared_test(
    perfect_game
    ${input_file_path_perfect_game}
    300
)

do_cli_shared_test(
    no_inputfile
    ""
    "usage: $<TARGET_FILE:bowling_game_cli_shared> inputfilename"
)

do_cli_shared_test(
    cant_open_inputfile
    cant_open_inputfile.txt
    "can't open cant_open_inputfile.txt"
)

#################################################################################

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
            WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
        )
    elseif(UNIX)
        add_test(
            NAME bowling_game_cli_static_test_${testname}
            COMMAND sh ${TEST_LUNCHER} bowling_game_cli_static_test_${testname} $<TARGET_FILE:bowling_game_cli_static> ${inputfile}
            WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
        )
    endif()
    set_tests_properties(
        bowling_game_cli_static_test_${testname} PROPERTIES
        PASS_REGULAR_EXPRESSION ${output}
    )
endmacro()

target_include_directories(bowling_game_cli_static
    PRIVATE lib/bowling_game/src
)
target_compile_options_helper(bowling_game_cli_static)

add_custom_command(
  TARGET bowling_game_cli_static POST_BUILD
  COMMAND ${CMAKE_COMMAND} -E copy $<TARGET_FILE:bowling_game_cli_static> ${CMAKE_BINARY_DIR}
)

do_cli_static_test(
    all_ones
    ${input_file_path_all_one_test}
    20
)

do_cli_static_test(
    all_zeros
    ${input_file_path_all_zeros}
    0
)

do_cli_static_test(
    one_spare
    ${input_file_path_one_spare}
    16
)

do_cli_static_test(
    one_strike
    ${input_file_path_one_strike}
    24
)

do_cli_static_test(
    perfect_game
    ${input_file_path_perfect_game}
    300
)

do_cli_static_test(
    no_inputfile
    ""
    "usage: $<TARGET_FILE:bowling_game_cli_static> inputfilename"
)

do_cli_static_test(
    cant_open_inputfile
    cant_open_inputfile.txt
    "can't open cant_open_inputfile.txt"
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
