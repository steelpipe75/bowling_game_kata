package bowling_game

type BowlingGame struct {
	rolls []int
}

func (bg *BowlingGame) Roll(pins int) {
	(*bg).rolls = append(bg.rolls, pins)
}

func (bg BowlingGame) Score() int {
	score := 0
	frameIndex := 0
	for frame := 0; frame < 10; frame++ {
		if bg.isStrike(frameIndex) {
			score += bg.strikeScore(frameIndex)
			frameIndex++
		} else if bg.isSpare(frameIndex) {
			score += bg.spareScore(frameIndex)
			frameIndex += 2
		} else {
			score += bg.rolls[frameIndex] + bg.rolls[frameIndex+1]
			frameIndex += 2
		}
	}
	return score
}

func (bg BowlingGame) isStrike(frameIndex int) bool {
	return (bg.rolls[frameIndex] == 10)
}

func (bg BowlingGame) isSpare(frameIndex int) bool {
	return ((bg.rolls[frameIndex] + bg.rolls[frameIndex+1]) == 10)
}

func (bg BowlingGame) strikeScore(frameIndex int) int {
	return 10 + bg.rolls[frameIndex+1] + bg.rolls[frameIndex+2]
}

func (bg BowlingGame) spareScore(frameIndex int) int {
	return 10 + bg.rolls[frameIndex+2]
}
