export class BowlingGame {
    private rolls: number[] = [];

    private isStrike(rollIndex: number): boolean {
        return this.rolls[rollIndex] === 10;
    }

    private isSpare(rollIndex: number): boolean {
        return this.rolls[rollIndex] + this.rolls[rollIndex + 1] === 10;
    }

    private strikeScore(frameIndex: number): number {
        return 10 + this.rolls[frameIndex + 1] + this.rolls[frameIndex + 2]
    }

    private spareScore(frameIndex: number): number {
        return 10 + this.rolls[frameIndex + 1]
    }

    roll(pins: number): void {
        this.rolls.push(pins);
    }

    score(): number {
        const maxIndex = this.rolls.length
        this.roll(0)
        this.roll(0)
        let score = 0;
        let frameIndex = 0;
        for (let frame = 0; frame < 10; frame++) {
            if (frameIndex >= maxIndex) {
                break;
            }
            if (this.isStrike(frameIndex)) {
                score += this.strikeScore(frameIndex)
                frameIndex += 1
            } else if (this.isSpare(frameIndex)) {
                score += this.spareScore(frameIndex)
                frameIndex += 2
            } else {
                score += this.rolls[frameIndex] + this.rolls[frameIndex + 1]
                frameIndex += 2
            }
        }
        return score;
    }
}
