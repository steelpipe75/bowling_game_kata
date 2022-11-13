extern "C" {
    #include "bowling_game.h"
}
#include "gtest/gtest.h"

namespace my {
namespace project {
namespace {

// The fixture for testing class bowling_game.
class bowling_game_test : public ::testing::Test {
  protected:
    // You can remove any or all of the following functions if their bodies would
    // be empty.

    bowling_game_test() {
        // You can do set-up work for each test here.
    }

    ~bowling_game_test() override {
        // You can do clean-up work that doesn't throw exceptions here.
    }

    // If the constructor and destructor are not enough for setting up
    // and cleaning up each test, you can define the following methods:

    void SetUp() override {
        // Code here will be called immediately after the constructor (right
        // before each test).
    }

    void TearDown() override {
        // Code here will be called immediately after each test (right
        // before the destructor).
    }

    // Class members declared here can be used by all tests in the test suite
    // for bowling_game.
};

static void roll_many(struct bowling_game * game, int n, int pins){
    int i;
    for(i=0; i<n; i++){
        bowling_game_roll(game, pins);
    }
}

TEST_F(bowling_game_test, gutter_game) {
    struct bowling_game * game;
    game = bowling_game_create();
    roll_many(game, 20, 0);
    EXPECT_EQ( 0, bowling_game_score(game) );
    bowling_game_destroy(game);
}

TEST_F(bowling_game_test, all_ones) {
    struct bowling_game * game;
    game = bowling_game_create();
    roll_many(game, 20, 1);
    EXPECT_EQ( 20, bowling_game_score(game) );
    bowling_game_destroy(game);
}

TEST_F(bowling_game_test, one_spare) {
    struct bowling_game * game;
    game = bowling_game_create();
    bowling_game_roll(game, 5);
    bowling_game_roll(game, 5);   /* spare */
    bowling_game_roll(game, 3);
    roll_many(game, 17, 0);
    EXPECT_EQ( 16, bowling_game_score(game) );
    bowling_game_destroy(game);
}

TEST_F(bowling_game_test, one_strike) {
    struct bowling_game * game;
    game = bowling_game_create();
    bowling_game_roll(game, 10);
    bowling_game_roll(game, 3);
    bowling_game_roll(game, 4);
    roll_many(game, 16, 0);
    EXPECT_EQ( 24, bowling_game_score(game) );
    bowling_game_destroy(game);
}

TEST_F(bowling_game_test, perfect_game) {
    struct bowling_game * game;
    game = bowling_game_create();
    roll_many(game, 12, 10);
    EXPECT_EQ( 300, bowling_game_score(game) );
    bowling_game_destroy(game);
}

}  // namespace
}  // namespace project
}  // namespace my

int main(int argc, char **argv) {
  ::testing::InitGoogleTest(&argc, argv);
  return RUN_ALL_TESTS();
}
