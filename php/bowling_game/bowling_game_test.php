<?php

require_once 'bowling_game.php';

use PHPUnit\Framework\TestCase;

class bowling_game_test extends TestCase {
    public function testPerfectGame() {
        $game = new BowlingGame();
        for ($i = 0; $i < 12; $i++) {
            $game->roll(10);
        }
        $this->assertSame(300, $game->score());
    }
}

?>
