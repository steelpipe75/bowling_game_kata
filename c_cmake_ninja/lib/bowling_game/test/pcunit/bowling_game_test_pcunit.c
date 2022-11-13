#include "bowling_game.h"
#include "PCUnit/PCUnit.h"
#include <stdio.h> /* for putchar */

/* ------------------------------------- */

static void roll_many(struct bowling_game * game, int n, int pins){
    int i;
    for(i=0; i<n; i++){
        bowling_game_roll(game, pins);
    }
}

/* ------------------------------------- */

static void test_gutter_game(){
    struct bowling_game * game;
    game = bowling_game_create();
    roll_many(game, 20, 0);
    PCU_ASSERT_EQUAL( 0, bowling_game_score(game) );
    bowling_game_destroy(game);
}

static void test_all_ones(){
    struct bowling_game * game;
    game = bowling_game_create();
    roll_many(game, 20, 1);
    PCU_ASSERT_EQUAL( 20, bowling_game_score(game) );
    bowling_game_destroy(game);
}

static void test_one_spare(){
    struct bowling_game * game;
    game = bowling_game_create();
    bowling_game_roll(game, 5);
    bowling_game_roll(game, 5);   /* spare */
    bowling_game_roll(game, 3);
    roll_many(game, 17, 0);
    PCU_ASSERT_EQUAL( 16, bowling_game_score(game) );
    bowling_game_destroy(game);
}

static void test_one_strike(){
    struct bowling_game * game;
    game = bowling_game_create();
    bowling_game_roll(game, 10);
    bowling_game_roll(game, 3);
    bowling_game_roll(game, 4);
    roll_many(game, 16, 0);
    PCU_ASSERT_EQUAL( 24, bowling_game_score(game) );
    bowling_game_destroy(game);
}

static void test_perfect_game(){
    struct bowling_game * game;
    game = bowling_game_create();
    roll_many(game, 12, 10);
    PCU_ASSERT_EQUAL( 300, bowling_game_score(game) );
    bowling_game_destroy(game);
}

/* ------------------------------------- */

PCU_Suite *BowlingGameTest_suite(void)
{
    static PCU_Test tests[] = {
        { "test_gutter_game",   test_gutter_game,   },
        { "test_all_ones",      test_all_ones,      },
        { "test_one_spare",     test_one_spare,     },
        { "test_one_strike",    test_one_strike,    },
        { "test_perfect_game",  test_perfect_game,  },
    };
    static PCU_Suite suite = { "BowlingGameTest", tests, sizeof tests / sizeof tests[0] };
    return &suite;
}

/* ------------------------------------- */

int main(void)
{
    const PCU_SuiteMethod suites[] = {
        BowlingGameTest_suite,
    };
    PCU_set_putchar(putchar);
    return PCU_run(suites, sizeof suites / sizeof suites[0]);
}
