import * as fs from 'fs';
import { BowlingGame } from "./bowling_game";

// コマンドライン引数からファイルパスを取得
const filePath = process.argv[2];

if (!filePath) {
    console.error('Usage: bun run index.ts <file-path>');
    process.exit(1);
}

// ファイルから一行ずつ整数値を読み込んでボーリングのスコア計算
function processFile(filePath: string): void {
    const bg = new BowlingGame();
    const fileContents = fs.readFileSync(filePath, 'utf-8').split('\n');
    fileContents.forEach((line, index) => {
        const intValue = parseInt(line.trim(), 10);
        if (isNaN(intValue)) {
            // console.error(`Error: Line ${index + 1} does not contain a valid integer.`);
            return;
        }
        if (intValue < 0) {
            // console.error(`Error: Negative integer found in line ${index + 1}.`);
            return;
        }
        bg.roll(intValue);
        // console.log(intValue);
    });
    console.log(bg.score());
}

// ファイルを処理
processFile(filePath);
