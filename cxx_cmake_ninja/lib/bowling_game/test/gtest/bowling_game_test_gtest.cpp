#include "bowling_game.hpp"
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

  static void roll_many(bowling_game* pGame, int n, int pins){
    int i;
    for(i=0; i<n; i++){
        pGame->roll(pins);
  }
}
};

TEST_F(bowling_game_test, gutter_game) {
    bowling_game game;
    roll_many(&game, 20, 0);
    EXPECT_EQ(0, game.score());
}

TEST_F(bowling_game_test, all_ones) {
    bowling_game game;
    roll_many(&game, 20, 1);
    EXPECT_EQ(20, game.score());
}

TEST_F(bowling_game_test, one_spare) {
    bowling_game game;
    game.roll(5);
    game.roll(5);   /* spare */
    game.roll(3);
    roll_many(&game, 17, 0);
    EXPECT_EQ(16, game.score());
}

TEST_F(bowling_game_test, one_strike) {
    bowling_game game;
    game.roll(10);
    game.roll(3);
    game.roll(4);
    roll_many(&game, 16, 0);
    EXPECT_EQ(24, game.score());
}

TEST_F(bowling_game_test, perfect_game) {
    bowling_game game;
    roll_many(&game, 12, 10);
    EXPECT_EQ(300, game.score());
}

}  // namespace
}  // namespace project
}  // namespace my

int main(int argc, char **argv) {
  ::testing::InitGoogleTest(&argc, argv);
  return RUN_ALL_TESTS();
}
