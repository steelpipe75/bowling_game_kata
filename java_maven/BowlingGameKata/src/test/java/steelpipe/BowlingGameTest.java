package steelpipe;

import static org.junit.Assert.assertEquals;
import org.junit.Test;

public class BowlingGameTest {

    @Test
    public void testAllZero() {
        BowlingGame bg = new BowlingGame();
        rollMany(bg, 20, 0);
        assertEquals(0, bg.score());
    }

    @Test
    public void testAllOnes() {
        BowlingGame bg = new BowlingGame();
        rollMany(bg, 20, 1);
        assertEquals(20, bg.score());
    }

    @Test
    public void testOneSpare() {
        BowlingGame bg = new BowlingGame();
        bg.roll(5);
        bg.roll(5);
        bg.roll(3);
        rollMany(bg, 17, 0);
        assertEquals(16, bg.score());
    }

    @Test
    public void testOneStrike() {
        BowlingGame bg = new BowlingGame();
        bg.roll(10);
        bg.roll(3);
        bg.roll(4);
        rollMany(bg, 16, 0);
        assertEquals(24, bg.score());
    }

    @Test
    public void testPerfectGame() {
        BowlingGame bg = new BowlingGame();
        rollMany(bg, 12, 10);
        assertEquals(300, bg.score());
    }

    private void rollMany(BowlingGame bg, int rolls, int pins) {
        for (int i = 0; i < rolls; i++) {
            bg.roll(pins);
        }
    }
}
