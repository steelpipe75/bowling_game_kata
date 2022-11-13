#include <iostream>
#include "bowling_game.hpp"

int main(int argc, char *argv[]){
    bowling_game* pGame;
    int pins;
    FILE *fp;
    errno_t error;

    if(argc == 2){
        error = fopen_s(&fp, argv[1], "r");
        if(error != 0){
            printf_s("can't open %s\n", argv[1]);
            return 1;
        }

        pGame = new bowling_game();

        while(1){
            fscanf(fp, "%d", &pins);
            if(pins < 0){
                break;
            }else{
                pGame->roll(pins);
            }
        }
        fclose(fp);

        printf_s("%d\n", pGame->score());

        delete pGame;

        return 0;
    }else{
        printf_s("usage: %s inputfilename\n", argv[0]);

        return 1;
    }
}