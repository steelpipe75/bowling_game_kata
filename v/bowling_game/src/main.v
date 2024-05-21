module main
import bowling_game
import os

fn main() {
	// コマンドライン引数をチェック
	if os.args.len < 2 {
		eprintln('Usage: ${os.args[0]} <filename>')
		exit(1)
	}
	filename := os.args[1]

	// ファイルをReadモードで開く
	file := os.read_file(filename) or {
		eprintln('Failed to open file: $err')
		exit(2)
	}

	mut bg := bowling_game.new_bowling_game()

	for line in file.split_into_lines() {
		value_i64 := line.parse_int(10, 0) or {
			eprintln('Invalid number: $line')
			exit(3)
		}
		if value_i64 < 0 {
			break
		}
		value_int := int(value_i64)
		bg.roll(value_int)
	}

	println(bg.score())
}
