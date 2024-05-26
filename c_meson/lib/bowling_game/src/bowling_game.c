#include "bowling_game.h"
#include <stdlib.h>

enum { max_rolls = 21 };
struct bowling_game{
    int rolls[max_rolls];
    int current_roll;
};

static bool is_strike(struct bowling_game * game, int frame_index){
    return ( game->rolls[frame_index] == 10 );
}

static bool is_spare(struct bowling_game * game, int frame_index){
    return ( (game->rolls[frame_index] + game->rolls[frame_index+1]) == 10 );
}

static int strike_score(struct bowling_game * game, int frame_index){
    return 10 + game->rolls[frame_index+1] + game->rolls[frame_index+2];
}

static int spare_score(struct bowling_game * game, int frame_index){
    return 10 + game->rolls[frame_index+2];
}

static int nomal_score(struct bowling_game * game, int frame_index){
    return game->rolls[frame_index] + game->rolls[frame_index+1];
}

DLL_EXPORT struct bowling_game * bowling_game_create(void){
    struct bowling_game * game;
    int i;

    game = malloc(sizeof(struct bowling_game));
    for(i=0; i<max_rolls; i++){
        game->rolls[i] = 0;
    }
    game->current_roll = 0;

    return game;
}

DLL_EXPORT void bowling_game_destroy(struct bowling_game * game){
    free(game);
}

DLL_EXPORT void bowling_game_roll(struct bowling_game * game, int pins){
    game->rolls[game->current_roll++] = pins;
}

DLL_EXPORT int bowling_game_score(struct bowling_game * game){
    int score = 0;
    int frame_index;
    int frame;
    frame_index=0;
    for(frame=0; frame<10; frame++){
        if( is_strike(game, frame_index) ){
            score += strike_score(game, frame_index);
            frame_index += 1;
        }else if( is_spare(game, frame_index) ){
            score += spare_score(game, frame_index);
            frame_index += 2;
        }else{
            score += nomal_score(game, frame_index);
            frame_index += 2;
        }
    }
    return score;
}
