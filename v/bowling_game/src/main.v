module main
import os

fn main() {
	println(os.args)
	mut f := os.open(os.args[1]) or { panic(err) }
	defer{ f.close() }
}
