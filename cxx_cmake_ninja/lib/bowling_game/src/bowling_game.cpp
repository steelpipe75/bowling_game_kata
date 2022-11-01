#include <iostream>
#include "bowling_game.hpp"

using namespace std;


bowling_game::bowling_game(){

}

bowling_game::~bowling_game(){

}

bool bowling_game::is_strike(int frame_index){
    return ( rolls[frame_index] == 10 );
}

bool bowling_game::is_spare(int frame_index){
    return ( (rolls[frame_index] + rolls[frame_index+1]) == 10 );
}

int bowling_game::strike_score(int frame_index){
    return 10 + rolls[frame_index+1] + rolls[frame_index+2];
}

int bowling_game::spare_score(int frame_index){
    return 10 + rolls[frame_index+2];
}

int bowling_game::nomal_score(int frame_index){
    return rolls[frame_index] + rolls[frame_index+1];
}

void bowling_game::roll(int pins){
    rolls[current_roll++] = pins;
}

int bowling_game::score(){
    int score = 0;
    int frame_index;
    int frame;
    frame_index=0;
    for(frame=0; frame<10; frame++){
        if( is_strike(frame_index) ){
            score += strike_score(frame_index);
            frame_index += 1;
        }else if( is_spare(frame_index) ){
            score += spare_score(frame_index);
            frame_index += 2;
        }else{
            score += nomal_score(frame_index);
            frame_index += 2;
        }
    }
    return score;
}
