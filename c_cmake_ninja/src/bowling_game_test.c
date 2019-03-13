#include "bowling_game.h"
#include <assert.h>

static void roll_many(int n, int pins){
    int i;
    for(i=0; i<n; i++){
        bowling_game_roll(pins);
    }
}

static void test_one_spare(){
    bowling_game_init();
    bowling_game_roll(5);
    bowling_game_roll(5);   /* spare */
    bowling_game_roll(3);
    roll_many(17, 0);
    assert( bowling_game_score() == 16 && "test_one_spare()" );
}

static void test_gutter_game(){
    int i;
    bowling_game_init();
    roll_many(20, 0);
    assert( bowling_game_score() == 0 && "test_gutter_game()" );
}

static void test_all_ones(){
    int i;
    bowling_game_init();
    roll_many(20, 1);
    assert( bowling_game_score() == 20 && "test_all_ones");
}

int main(){
    test_gutter_game();
    test_all_ones();
    test_one_spare();

    return 0;
}
