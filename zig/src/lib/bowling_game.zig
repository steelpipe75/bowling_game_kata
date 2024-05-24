const std = @import("std");

pub const BowlingGame = struct {
    rolls: [21]u8,
    currentRoll: usize,

    pub fn init() BowlingGame {
        return BowlingGame{
            .rolls = [_]u8{0} ** 21,
            .currentRoll = 0,
        };
    }

    pub fn roll(self: *BowlingGame, pins: u8) void {
        if (self.currentRoll < self.rolls.len) {
            self.rolls[self.currentRoll] = pins;
            self.currentRoll += 1;
        }
    }

    pub fn score(self: *BowlingGame) u16 {
        var total_score: u16 = 0;
        var frameIndex: usize = 0;
        for (0..10) |_| {
            if (frameIndex >= self.currentRoll) {
                break;
            }
            if (self.rolls[frameIndex] == 10) { // Strike
                total_score += 10 + self.rolls[frameIndex + 1] + self.rolls[frameIndex + 2];
                frameIndex += 1;
            } else if (self.rolls[frameIndex] + self.rolls[frameIndex + 1] == 10) { // Spare
                total_score += 10 + self.rolls[frameIndex + 2];
                frameIndex += 2;
            } else {
                total_score += self.rolls[frameIndex] + self.rolls[frameIndex + 1];
                frameIndex += 2;
            }
        }
        return total_score;
    }
};
