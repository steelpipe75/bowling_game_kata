import sys
import bowling_game.bowling_game as bg

if __name__ == '__main__':
    args = sys.argv
    if len(args) == 2:
        f = open( args[1], 'r')
        datalist = f.readlines()
        f.close()
        game = bg.BowlingGame()
        for data in datalist:
            if int(data) > 0:
                # print(data, end='')
                game.roll(int(data))
        print(game.score())
        sys.exit(0)
    else:
        print('Usage: python ' + args[0] + '<inputfilename>')
        sys.exit(1)
