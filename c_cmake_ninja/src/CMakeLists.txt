cmake_minimum_required(VERSION 3.13)

project(bowling_game_cli)
enable_testing()
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
    bowling_game_cli.c
)

configure_file(build_and_run.bat.in build_and_run.bat COPYONLY)
