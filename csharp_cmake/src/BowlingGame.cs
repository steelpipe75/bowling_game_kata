using System.Collections.Generic;

namespace BowlingGameNamespace
{
    class BowlingGame 
    {
        private List<int> rolls;
        
        public BowlingGame(){
            rolls = new List<int>();
        }

        public void Roll(int pins){
            rolls.Add(pins);
        }

        public int Score(){
            int maxIndex = rolls.Count;
            Roll(0);
            Roll(0);
            int score = 0;
            int frameIndex = 0;
            for(int frame = 0; frame < 10; frame++){
                if(frameIndex >= maxIndex){
                    break;
                }
                if(IsStrike(frameIndex)){
                    score += StrikeScore(frameIndex);
                    frameIndex++;
                }else if(IsSpare(frameIndex)){
                    score += SpareScpre(frameIndex);
                    frameIndex += 2;
                }else{
                    score += rolls[frameIndex] + rolls[frameIndex+1];
                    frameIndex += 2;
                }
            }
            return score;
        }

        private bool IsStrike(int frameIndex){
            return rolls[frameIndex] == 10;
        }

        private bool IsSpare(int frameIndex){
            return (rolls[frameIndex] + rolls[frameIndex+1])== 10;
        }

        private int StrikeScore(int frameIndex){
            return 10 + rolls[frameIndex+1] + rolls[frameIndex+2];
        }

        private int SpareScpre(int frameIndex){
            return 10 + rolls[frameIndex+2];
        }
    }
}
