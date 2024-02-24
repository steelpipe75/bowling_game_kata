import unittest

import os
import sys
sys.path.append(os.path.join(os.path.dirname(__file__), '..'))
from bowling_game import bowling_game as bg

class TestBowlingGame(unittest.TestCase):
    def test_all_zeros(self):
        game = bg.BowlingGame()
        for i in range(20):
            game.roll(0)
        self.assertEqual(game.score(), 0)

    def test_all_ones(self):
        game = bg.BowlingGame()
        for i in range(20):
            game.roll(1)
        self.assertEqual(game.score(), 20)

    def test_one_spare(self):
        game = bg.BowlingGame()
        game.roll(5)
        game.roll(5)
        game.roll(3)
        for i in range(17):
            game.roll(0)
        self.assertEqual(game.score(), 16)

    def test_one_strike(self):
        game = bg.BowlingGame()
        game.roll(10)
        game.roll(3)
        game.roll(4)
        for i in range(16):
            game.roll(0)
        self.assertEqual(game.score(), 24)

    def test_perfect_game(self):
        game = bg.BowlingGame()
        for i in range(12):
            game.roll(10)
        self.assertEqual(game.score(), 300)


if __name__ == '__main__':
    unittest.main()
