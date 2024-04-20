using System.Collections.Generic;

namespace BowlingGameNameSpace
{
    class BowlingGame
    {
        private List<int> rolls;
        
        public BowlingGame(){
            rolls = new List<int>();
        }

        public void roll(int pins)
        {
            rolls.Add(pins);
        }

        public int score()
        {
            return 0;
        }
    }
}
