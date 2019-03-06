cmake_minimum_required(VERSION 3.13)

project(bowling_game_test)
add_executable(bowling_game_test bowling_game_test.c bowling_game.c)
configure_file(build_and_run.bat.in build_and_run.bat COPYONLY)
