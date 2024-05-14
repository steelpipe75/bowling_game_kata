# 動作確認できたCMakeのバージョン
cmake_minimum_required(VERSION 3.25.0)

# project情報
project(bowling_game
        DESCRIPTION "ボーリングのスコア計算 cliツール project"
        LANGUAGES CSharp
)

# in-source ビルドガード
if(${CMAKE_SOURCE_DIR} STREQUAL ${CMAKE_BINARY_DIR})
    message(FATAL_ERROR "In-source builds not allowed. Please make a new directory (called a build directory) and run CMake from there. You may need to remove CMakeCache.txt. ")
endif()

#################################################################################

add_executable(
    bowling_game_cli

    src/BowlingGameCli.cs
    src/BowlingGame.cs
)

