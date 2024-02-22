import bowling_game.bowling_game as bg

if __name__ == '__main__':
    game = bg.BowlingGame()

    game.roll(10)
    game.roll(10)
    game.roll(10)
    game.roll(10)
    game.roll(10)
    game.roll(10)
    game.roll(10)
    game.roll(10)
    game.roll(10)
    game.roll(10)
    game.roll(10)
    game.roll(10)

    score = game.score()
    print(score)

    pass
