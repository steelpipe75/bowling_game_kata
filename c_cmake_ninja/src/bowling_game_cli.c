#include "bowling_game.h"
#include <stdio.h>

int main(){
    struct bowling_game * game;
    game = bowling_game_create();
    int pins;

    while(1){
        scanf("%d", &pins);
        if(pins < 0){
            break;
        }else{
            bowling_game_roll(game, pins);
        }
    }

    printf("%d\n", bowling_game_score(game));

    bowling_game_destroy(game);

    return 0;
}
