#include "bowling_game.h"
#include <assert.h>

static void roll_many(struct bowling_game * game, int n, int pins){
    int i;
    for(i=0; i<n; i++){
        bowling_game_roll(game, pins);
    }
}

static void test_all_zeros(){
    struct bowling_game * game;
    game = bowling_game_create();
    roll_many(game, 20, 0);
    assert( bowling_game_score(game) == 0 && "test_all_zeros()" );
    bowling_game_destroy(game);
}

static void test_all_ones(){
    struct bowling_game * game;
    game = bowling_game_create();
    roll_many(game, 20, 1);
    assert( bowling_game_score(game) == 20 && "test_all_ones");
    bowling_game_destroy(game);
}

static void test_one_spare(){
    struct bowling_game * game;
    game = bowling_game_create();
    bowling_game_roll(game, 5);
    bowling_game_roll(game, 5);   /* spare */
    bowling_game_roll(game, 3);
    roll_many(game, 17, 0);
    assert( bowling_game_score(game) == 16 && "test_one_spare()" );
    bowling_game_destroy(game);
}

static void test_one_strike(){
    struct bowling_game * game;
    game = bowling_game_create();
    bowling_game_roll(game, 10);
    bowling_game_roll(game, 3);
    bowling_game_roll(game, 4);
    roll_many(game, 16, 0);
    assert( bowling_game_score(game) == 24 && "test_one_strike()" );
    bowling_game_destroy(game);
}

static void test_perfect_game(){
    struct bowling_game * game;
    game = bowling_game_create();
    roll_many(game, 12, 10);
    assert( bowling_game_score(game) == 300 && "test_perfect_game()" );
    bowling_game_destroy(game);
}

int main(){
    test_all_zeros();
    test_all_ones();
    test_one_spare();
    test_one_strike();
    test_perfect_game();

    return 0;
}
