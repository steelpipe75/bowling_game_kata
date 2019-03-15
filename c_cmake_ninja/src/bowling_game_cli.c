#include "bowling_game.h"
#include <stdio.h>

int main(int argc, char *argv[]){
    struct bowling_game * game;
    int pins;
    FILE *fp;
    errno_t error;

    if(argc == 2){
        error = fopen_s(&fp, argv[1], "r");
        if(error != 0){
            printf_s("can't open %s\n", argv[1]);
            return 1;
        }

        game = bowling_game_create();

        while(1){
            fscanf(fp, "%d", &pins);
            if(pins < 0){
                break;
            }else{
                bowling_game_roll(game, pins);
            }
        }
        fclose(fp);

        printf_s("%d\n", bowling_game_score(game));

        bowling_game_destroy(game);

        return 0;
    }else{
        printf_s("usage: %s inputfilename\n", argv[0]);

        return 1;
    }
}
