package bowling_game

type BowlingGame struct {
	rolls []int
}

func (bg BowlingGame) Roll(pins int) {
	bg.rolls = append(bg.rolls, pins)
}

func (bg BowlingGame) Score() int {
	return 0
}
