namespace BowlingGameLib.Tests;
using BowlingGameLib;

public class BowlingGameTests
{
    [Fact]
    public void TestAllZero()
    {
        var bg = new BowlingGame();

        for (int i = 0; i < 20; i++){
            bg.Roll(0);
        }

        Assert.Equal(0, bg.Score());
    }

    [Fact]
    public void TestAllOnes()
    {
        var bg = new BowlingGame();

        for (int i = 0; i < 20; i++){
            bg.Roll(1);
        }

        Assert.Equal(20, bg.Score());
    }

    [Fact]
    public void TestOneSpare()
    {
        var bg = new BowlingGame();

        bg.Roll(5);
        bg.Roll(5);
        bg.Roll(3);
        for (int i = 0; i < 17; i++){
            bg.Roll(0);
        }

        Assert.Equal(16, bg.Score());
    }

    [Fact]
    public void TestOneStrike()
    {
        var bg = new BowlingGame();

        bg.Roll(10);
        bg.Roll(3);
        bg.Roll(4);
        for (int i = 0; i < 16; i++){
            bg.Roll(0);
        }

        Assert.Equal(24, bg.Score());
    }

    [Fact]
    public void TestPerfectGame()
    {
        var bg = new BowlingGame();

        for (int i = 0; i < 12; i++){
            bg.Roll(10);
        }

        Assert.Equal(300, bg.Score());
    }
}
