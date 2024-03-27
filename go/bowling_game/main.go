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
		pins, err := strconv.Atoi(v)
		if err != nil {
			continue
		}
		bg.Roll(pins)
	}

	score := bg.Score()
	fmt.Println(score)
}
