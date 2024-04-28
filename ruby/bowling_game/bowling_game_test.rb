require 'minitest/autorun'
require_relative 'bowling_game'

class BowlingGameTest < Minitest::Test
  def setup
    @bg = BowlingGame.new
  end

  def test_all_zeros
    20.times { @bg.roll(0) }
    assert_equal 0, @bg.score
  end

  def test_all_one
    20.times { @bg.roll(1) }
    assert_equal 20, @bg.score
  end

  def test_one_spare
    @bg.roll(5)
    @bg.roll(5)
    @bg.roll(3)
    17.times { @bg.roll(0) }
    assert_equal 16, @bg.score
  end

  def test_one_strike
    @bg.roll(10)
    @bg.roll(3)
    @bg.roll(4)
    16.times { @bg.roll(0) }
    assert_equal 24, @bg.score
  end

  def test_parfect_game
    12.times { @bg.roll(10) }
    assert_equal 300, @bg.score
  end
end
