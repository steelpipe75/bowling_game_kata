package steelpipe;

public class BowlingGame {

    private int[] rolls = new int[21];
    private int currentRoll = 0;

    public void roll(int pins) {
        rolls[currentRoll++] = pins;
    }

    public int score() {
        int score = 0;
        int rollIndex = 0;

        for (int frame = 0; frame < 10; frame++) {
            if (rolls[rollIndex] == 10) { // ストライクの場合
                score += 10 + rolls[rollIndex + 1] + rolls[rollIndex + 2];
                rollIndex++;
            } else if (rolls[rollIndex] + rolls[rollIndex + 1] == 10) { // スペアの場合
                score += 10 + rolls[rollIndex + 2];
                rollIndex += 2;
            } else { // その他の場合
                score += rolls[rollIndex] + rolls[rollIndex + 1];
                rollIndex += 2;
            }
        }

        return score;
    }
}
