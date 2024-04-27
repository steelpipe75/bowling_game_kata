const fs = require('fs');
const BowlingGame = require('./bowling_game');

// コマンドライン引数からファイル名を取得
const fileName = process.argv[2];

if (!fileName) {
  console.error("Usage: bun run index.js <file_name>");
  process.exit(1); // 異常終了
}

// ファイルを非同期で読み込み、整数値を処理
fs.readFile(fileName, 'utf8', (err, data) => {
  if (err) {
    // console.error("Error reading file:", err);
    process.exit(1); // 異常終了
  }

  const bg = new BowlingGame();

  // ファイルの内容を一行ずつ処理
  data.split('\n').forEach(line => {
    // 空行の場合はスキップ
    if (!line.trim()) return;

    // 整数値に変換
    const number = parseInt(line, 10);

    // 負の値の場合はプログラムを終了
    if (number < 0) {
      // console.error("Negative number detected. Exiting...");
    }

    bg.roll(number);
  });

  console.log(bg.score());
});
