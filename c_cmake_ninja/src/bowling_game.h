#ifndef BOWLING_GAME_H
#define BOWLING_GAME_H

#include <stdbool.h>

struct bowling_game;
extern struct bowling_game * bowling_game_create(void);
extern void bowling_game_destroy(struct bowling_game * game);
extern void bowling_game_roll(struct bowling_game * game, int pins);
extern int bowling_game_score(struct bowling_game * game);

#endif
