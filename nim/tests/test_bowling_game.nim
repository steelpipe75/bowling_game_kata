import std/unittest
import ../src/lib/bowling_game

suite "bowling_game":
  test "all ones":
    var bg = newBowlingGame()
    for i in countup(1, 20):
      bg.roll(0)
    assert bg.score() == 0

  test "all zero":
    var bg = newBowlingGame()
    for i in countup(1, 20):
      bg.roll(1)
    assert bg.score() == 20

  test "one spare":
    var bg = newBowlingGame()
    bg.roll(5)
    bg.roll(5)
    bg.roll(3)
    for i in countup(1, 17):
      bg.roll(0)
    assert bg.score() == 16

  test "one strike":
    var bg = newBowlingGame()
    bg.roll(10)
    bg.roll(3)
    bg.roll(4)
    for i in countup(1, 16):
      bg.roll(0)
    assert bg.score() == 24

  test "perfect game":
    var bg = newBowlingGame()
    for i in countup(1, 12):
      bg.roll(10)
    assert bg.score() == 300

