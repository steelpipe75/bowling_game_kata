package main

import (
	"bowling_game/bowling_game"
	"fmt"
)

func main() {
	bg := bowling_game.BowlingGame{}

	for i := 0; i < 20; i++ {
		bg.Roll(0)
	}

	score := bg.Score()
	fmt.Println("Total Score:", score)
}
