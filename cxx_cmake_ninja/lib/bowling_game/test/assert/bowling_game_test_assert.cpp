#include <iostream>
#include <cassert>
#include "bowling_game.hpp"

static void roll_many(bowling_game* pGame, int n, int pins){
    int i;
    for(i=0; i<n; i++){
        pGame->roll(pins);
    }
}

static void test_gutter_game(){
    bowling_game game;
    roll_many(&game, 20, 0);
    assert( game.score() == 0 && "test_gutter_game()" );
}

static void test_all_ones(){
    bowling_game game;
    roll_many(&game, 20, 1);
    assert( game.score() == 20 && "test_all_ones");
}

static void test_one_spare(){
    bowling_game game;
    game.roll(5);
    game.roll(5);   /* spare */
    game.roll(3);
    roll_many(&game, 17, 0);
    assert( game.score() == 16 && "test_one_spare()" );
}

static void test_one_strike(){
    bowling_game game;
    game.roll(10);
    game.roll(3);
    game.roll(4);
    roll_many(&game, 16, 0);
    assert( game.score() == 24 && "test_one_strike()" );
}

static void test_perfect_game(){
    bowling_game game;
    roll_many(&game, 12, 10);
    assert( game.score() == 300 && "test_perfect_game()" );
}

int main(){
    test_gutter_game();
    test_all_ones();
    test_one_spare();
    test_one_strike();
    test_perfect_game();

    return 0;
}
