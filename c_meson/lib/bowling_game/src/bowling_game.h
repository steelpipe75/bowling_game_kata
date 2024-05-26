#ifndef BOWLING_GAME_H
#define BOWLING_GAME_H

#include <stdbool.h>

#ifdef _MSC_VER
    #define DLL_EXPORT __declspec(dllexport)
#else
    #define DLL_EXPORT 
#endif

struct bowling_game;
extern DLL_EXPORT struct bowling_game * bowling_game_create(void);
extern DLL_EXPORT void bowling_game_destroy(struct bowling_game * game);
extern DLL_EXPORT void bowling_game_roll(struct bowling_game * game, int pins);
extern DLL_EXPORT int bowling_game_score(struct bowling_game * game);

#endif
