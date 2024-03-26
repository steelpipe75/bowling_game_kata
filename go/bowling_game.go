package main

import (
	"fmt"
)

type BowlingGame struct {
	rolls []int
}

func (bg BowlingGame) roll(pins int) {
	bg.rolls = append(bg.rolls, pins)
}

func (bg BowlingGame) score() int {
	return 0
}

func main() {
	bg := BowlingGame{}

	for i := 0; i < 20; i++ {
		bg.roll(0)
	}

	score := bg.score()
	fmt.Println("Total Score:", score)
}
