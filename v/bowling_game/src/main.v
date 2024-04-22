module main
import bowling_game

fn main() {
	mut bg := bowling_game.new_bowling_game()

	bg.roll(1)
	bg.roll(1)

	bg.roll(1)
	bg.roll(1)

	bg.roll(1)
	bg.roll(1)

	bg.roll(1)
	bg.roll(1)

	bg.roll(1)
	bg.roll(1)

	bg.roll(1)
	bg.roll(1)

	bg.roll(1)
	bg.roll(1)

	bg.roll(1)
	bg.roll(1)

	bg.roll(1)
	bg.roll(1)

	bg.roll(1)
	bg.roll(1)

	println(bg.score())
}
