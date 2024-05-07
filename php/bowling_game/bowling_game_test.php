<?php

require_once 'bowling_game.php';

use PHPUnit\Framework\TestCase;

class bowling_game_test extends TestCase {
    public function testAllZerosGame() {
        $game = new BowlingGame();
        for ($i = 0; $i < 20; $i++) {
            $game->roll(0);
        }
        $this->assertSame(0, $game->score());
    }

    public function testAllOnesGame() {
        $game = new BowlingGame();
        for ($i = 0; $i < 20; $i++) {
            $game->roll(1);
        }
        $this->assertSame(20, $game->score());
    }

    public function testOneSpareGame() {
        $game = new BowlingGame();
        $game->roll(5);
        $game->roll(5);
        $game->roll(3);
        for ($i = 0; $i < 17; $i++) {
            $game->roll(0);
        }
        $this->assertSame(16, $game->score());
    }

    public function testOneStrikeGame() {
        $game = new BowlingGame();
        $game->roll(10);
        $game->roll(3);
        $game->roll(4);
        for ($i = 0; $i < 16; $i++) {
            $game->roll(0);
        }
        $this->assertSame(24, $game->score());
    }

    public function testPerfectGame() {
        $game = new BowlingGame();
        for ($i = 0; $i < 12; $i++) {
            $game->roll(10);
        }
        $this->assertSame(300, $game->score());
    }
}

?>
