import bowling_game

fn test_all_zero() {
	mut bg := bowling_game.new_bowling_game()
	for i := 0; i < 20; i++ {
		bg.roll(0)
	}
	assert bg.score() == 0
}

fn test_all_ones() {
	mut bg := bowling_game.new_bowling_game()
	for i := 0; i < 20; i++ {
		bg.roll(1)
	}
	assert bg.score() == 20
}

fn test_one_spare() {
	mut bg := bowling_game.new_bowling_game()
	bg.roll(5)
	bg.roll(5)
	bg.roll(3)
	for i := 0; i < 17; i++ {
		bg.roll(0)
	}
	assert bg.score() == 16
}

fn test_one_strike() {
	mut bg := bowling_game.new_bowling_game()
	bg.roll(10)
	bg.roll(3)
	bg.roll(4)
	for i := 0; i < 16; i++ {
		bg.roll(0)
	}
	assert bg.score() == 24
}

fn test_perfect_game() {
	mut bg := bowling_game.new_bowling_game()
	for i := 0; i < 12; i++ {
		bg.roll(10)
	}
	assert bg.score() == 300
}
