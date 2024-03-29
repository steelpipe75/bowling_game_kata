#define __STDC_WANT_LIB_EXT1__ 1
#include "bowling_game.h"
#include <stdio.h>

int main(int argc, char *argv[]){
    struct bowling_game * game;
    int pins;
    FILE *fp;
#ifdef __STDC_LIB_EXT1__
    errno_t error;
#endif /* #ifdef __STDC_LIB_EXT1__ */

    if(argc == 2){
#ifdef __STDC_LIB_EXT1__
        error = fopen_s(&fp, argv[1], "r");
        if(error != 0){
            printf_s("can't open %s\n", argv[1]);
            return 1;
        }
#else /* #ifdef __STDC_LIB_EXT1__ */
        fp = fopen(argv[1], "r");
        if(fp == NULL){
            printf("can't open %s\n", argv[1]);
            return 1;
        }
#endif /* #ifdef __STDC_LIB_EXT1__ */

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

#ifdef __STDC_LIB_EXT1__
        printf_s("%d\n", bowling_game_score(game));
#else /* #ifdef __STDC_LIB_EXT1__ */
        printf("%d\n", bowling_game_score(game));
#endif /* #ifdef __STDC_LIB_EXT1__ */

        bowling_game_destroy(game);

        return 0;
    }else{
#ifdef __STDC_LIB_EXT1__
        printf_s("usage: %s inputfilename\n", argv[0]);
#else /* #ifdef __STDC_LIB_EXT1__ */
        printf("usage: %s inputfilename\n", argv[0]);
#endif /* #ifdef __STDC_LIB_EXT1__ */

        return 1;
    }
}
