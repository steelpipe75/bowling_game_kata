use std::env;
use std::fs::File;
use std::io::{self, BufRead};

mod bowling_game;

use bowling_game::BowlingGame;

fn main() -> io::Result<()> {
    // コマンドライン引数からファイル名を取得
    let args: Vec<String> = env::args().collect();
    if args.len() < 2 {
        eprintln!("Usage: {} <filename>", args[0]);
        std::process::exit(1);
    }
    let filename = &args[1];

    // ファイルを開く
    let file = File::open(filename)?;
    let reader = io::BufReader::new(file);

    let mut bg = BowlingGame::new();

    // ファイルから一行ずつ読み込む
    for line in reader.lines() {
        let line = line?;
        let num: i32 = match line.trim().parse() {
            Ok(n) => n,
            Err(e) => {
                eprintln!("Error parsing line: {}", e);
                continue;
            }
        };
        if num < 0 {
            break
        } else {
            bg.roll(num)
        }
    }

    println!("{}", bg.score());

    Ok(())
}
