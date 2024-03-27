package main

import (
	"bowling_game/bowling_game"
	"fmt"
	"os"
	"strconv"
)

func main() {
	bg := bowling_game.BowlingGame{}

	for _, v := range os.Args {
		pins, _ := strconv.Atoi(v)
		bg.Roll(pins)
	}

	score := bg.Score()
	fmt.Println(score)
}
