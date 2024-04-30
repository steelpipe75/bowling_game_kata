<?php

class BowlingGame {
    private $rolls = [];

    // 投球を登録するメソッド
    public function roll($pins) {
        $this->rolls[] = $pins;
    }

    // スコアを計算するメソッド
    public function score() {
        $score = 0;
        $frameIndex = 0;

        for ($frame = 0; $frame < 10; $frame++) {
            if ($this->isStrike($frameIndex)) { // ストライク
                $score += $this->strikeScore($frameIndex);
                $frameIndex++;
            } elseif ($this->isSpare($frameIndex)) { // スペア
                $score += $this->spareScore($frameIndex);
                $frameIndex += 2;
            } else {
                $score += $this->rolls[$frameIndex] + $this->rolls[$frameIndex + 1];
                $frameIndex += 2;
            }
        }

        return $score;
    }

    // ストライクかどうかを判定するメソッド
    private function isStrike($frameIndex) {
        return $this->rolls[$frameIndex] == 10;
    }

    // スペアかどうかを判定するメソッド
    private function isSpare($frameIndex) {
        return $this->rolls[$frameIndex] + $this->rolls[$frameIndex + 1] == 10;
    }

    // ストライクのスコア計算
    private function strikeScore($frameIndex) {
        return 10 + $this->rolls[$frameIndex + 1] + $this->rolls[$frameIndex + 2];
    }

    // スペアのスコア計算
    private function spareScore($frameIndex) {
        return 10 + $this->rolls[$frameIndex + 2];
    }
}

?>
