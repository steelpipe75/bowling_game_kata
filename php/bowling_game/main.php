<?php

require_once 'bowling_game.php';

// 引数の数が正しいか確認
if ($argc != 2) {
    echo "Usage: php script.php <filename>\n";
    exit(1);
}

// ファイルの存在を確認
$filename = $argv[1];
if (!file_exists($filename)) {
    echo "Error: File not found.\n";
    exit(1);
}

// ファイルを開く
$file = fopen($filename, "r");
if (!$file) {
    echo "Error: Unable to open file.\n";
    exit(1);
}

$bg = new BowlingGame();

// ファイルから整数を読み込み
while (($line = fgets($file)) !== false) {
    $number = intval(trim($line));
    if ($number < 0) {
        break;
    }
    $bg->roll($number);
}

// ファイルを閉じる
fclose($file);
$score = $bg->score();
echo "$score\n";
?>
