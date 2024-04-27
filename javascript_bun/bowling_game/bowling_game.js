class BowlingGame {
  constructor() {
    this.rolls = [];
  }

  roll(pins) {
    this.rolls.push(pins);
  }

  score() {
    const maxIndex = this.rolls.length;
    this.roll(0)
    this.roll(0)

    let score = 0;
    let frameIndex = 0;
    for (let frame = 0; frame < 10; frame++) {
      if (frameIndex >= maxIndex) {
        break;
      }
      if (this.isStrike(frameIndex)) {
        score += this.strikeScore(frameIndex);
        frameIndex++;
      } else if (this.isSpare(frameIndex)) {
        score += this.spareScore(frameIndex);
        frameIndex += 2;
      } else {
        score += this.rolls[frameIndex] + this.rolls[frameIndex + 1];
        frameIndex += 2;
      }
    }

    return score;
  }

  isStrike(frameIndex) {
    return this.rolls[frameIndex] === 10;
  }

  isSpare(frameIndex) {
    return this.rolls[frameIndex] + this.rolls[frameIndex + 1] === 10;
  }

  strikeScore(frameIndex) {
    return 10 + this.rolls[frameIndex + 1] + this.rolls[frameIndex + 2];
  }

  spareScore(frameIndex) {
    return 10 + this.rolls[frameIndex + 2];
  }
}

module.exports = BowlingGame;
