#ifndef BOWLING_GAME_H
#define BOWLING_GAME_H

#include <stdbool.h>

extern void bowling_game_init(void);
extern void bowling_game_roll(int pins);
extern int bowling_game_score(void);

#endif
