module bowling_game

pub struct BowlingGame{
mut:
	 rolls []int
}

pub fn new_bowling_game() &BowlingGame {
	return &BowlingGame{
		rolls: []int{}
	}
}

pub fn (mut bg BowlingGame) roll(pins int) {
	bg.rolls << pins
}

pub fn (mut bg BowlingGame) score() int {
	max_index := bg.rolls.len
	bg.roll(0)
	bg.roll(0)
	mut score := 0
	mut frame_index := 0
	for frame := 0; frame < 10; frame++ {
		if frame_index >= max_index {
			break
		}
		if bg.is_strike(frame_index) {
			score += bg.strike_score(frame_index)
			frame_index++
		} else if bg.is_spare(frame_index) {
			score += bg.spare_score(frame_index)
			frame_index += 2
		} else {
			score += bg.rolls[frame_index] + bg.rolls[frame_index+1]
			frame_index += 2
		}
	}
	return score
}

fn (bg BowlingGame) is_strike(frameIndex int) bool {
	return (bg.rolls[frameIndex] == 10)
}

fn (bg BowlingGame) is_spare(frameIndex int) bool {
	return ((bg.rolls[frameIndex] + bg.rolls[frameIndex+1]) == 10)
}

fn (bg BowlingGame) strike_score(frameIndex int) int {
	return 10 + bg.rolls[frameIndex+1] + bg.rolls[frameIndex+2]
}

fn (bg BowlingGame) spare_score(frameIndex int) int {
	return 10 + bg.rolls[frameIndex+2]
}
