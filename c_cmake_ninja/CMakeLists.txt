cmake_minimum_required(VERSION 3.13)

project(bowling_game_cli)
enable_testing()

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

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
