# 動作確認できたCMakeのバージョン
cmake_minimum_required(VERSION 3.16)

# project情報
project(bowling_game
        DESCRIPTION "ボーリングのスコア計算 ライブラリ project"
        LANGUAGES CXX
)

#################################################################################

add_library(
    bowling_game_share
    SHARED
    src/bowling_game.cpp
)

target_include_directories(
    bowling_game_share
    PUBLIC 
    src
)

#################################################################################

add_library(
    bowling_game_static
    STATIC
    src/bowling_game.cpp
)

target_include_directories(
    bowling_game_static
    PUBLIC 
    src
)
