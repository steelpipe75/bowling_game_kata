#include "bowling_game.h"

enum { max_rolls = 21 };
static int rolls[max_rolls];
static int current_roll;

static bool is_strike(int frame_index){
    return ( rolls[frame_index] == 10 );
}

static bool is_spare(int frame_index){
    return ( (rolls[frame_index] + rolls[frame_index+1]) == 10 );
}

static int strike_score(int frame_index){
    return 10 + rolls[frame_index+1] + rolls[frame_index+2];
}

static int spare_score(int frame_index){
    return 10 + rolls[frame_index+2];
}

static int nomal_score(int frame_index){
    return rolls[frame_index] + rolls[frame_index+1];
}

void bowling_game_init(void){
    int i;
    for(i=0; i<max_rolls; i++){
        rolls[i] = 0;
    }
    current_roll = 0;
}

void bowling_game_roll(int pins){
    rolls[current_roll++] = pins;
}

int bowling_game_score(){
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
