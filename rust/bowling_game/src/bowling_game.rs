pub struct BowlingGame {
    rolls: Vec<i32>,
}

impl BowlingGame {
    pub fn new() -> BowlingGame {
        BowlingGame { rolls: Vec::new() }
    }

    pub fn roll(&mut self, pins: i32) {
        self.rolls.push(pins);
    }

    pub fn score(&self) -> i32 {
        let mut score = 0;
        let mut frame_index = 0;
        let max_index = self.rolls.len();
        for _ in 0..10 {
            if frame_index >= max_index {
                break
            }
            if self.is_strike(frame_index) {
                score += self.strike_score(frame_index);
                frame_index += 1;
            } else if self.is_spare(frame_index) {
                score += self.spare_score(frame_index);
                frame_index += 2;
            } else {
                score += self.rolls[frame_index] + self.rolls[frame_index+1];
                frame_index += 2;
            }
        }
        score
    }

    fn is_strike(&self, frame_index: usize) -> bool {
        self.rolls[frame_index] == 10
    }

    fn is_spare(&self, frame_index: usize) -> bool {
        self.rolls[frame_index] + self.rolls[frame_index + 1] == 10
    }

    fn strike_score(&self, frame_index: usize) -> i32 {
        10 + self.rolls[frame_index + 1] + self.rolls[frame_index + 2]
    }

    fn spare_score(&self, frame_index: usize) -> i32 {
        10 + self.rolls[frame_index + 2]
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_score_all_zero() {
        let mut bg = BowlingGame::new();
        for _ in 0..20 {
            bg.roll(0);
        }
        assert_eq!(bg.score(), 0);
    }

    #[test]
    fn test_score_all_ones() {
        let mut bg = BowlingGame::new();
        for _ in 0..20 {
            bg.roll(1);
        }
        assert_eq!(bg.score(), 20);
    }

    #[test]
    fn test_score_one_spare() {
        let mut bg = BowlingGame::new();
        bg.roll(5);
        bg.roll(5);
        bg.roll(3);
        for _ in 0..17 {
            bg.roll(0);
        }
        assert_eq!(bg.score(), 16);
    }

    #[test]
    fn test_score_one_strike() {
        let mut bg = BowlingGame::new();
        bg.roll(10);
        bg.roll(3);
        bg.roll(4);
        for _ in 0..16 {
            bg.roll(0);
        }
        assert_eq!(bg.score(), 24);
    }

    #[test]
    fn test_score_perfect_game() {
        let mut bg = BowlingGame::new();
        for _ in 0..12 {
            bg.roll(10);
        }
        assert_eq!(bg.score(), 300);
    }
}
