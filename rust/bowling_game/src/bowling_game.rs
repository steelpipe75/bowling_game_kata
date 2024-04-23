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
