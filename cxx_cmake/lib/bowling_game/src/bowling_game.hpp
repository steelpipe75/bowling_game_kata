#ifndef BOWLING_GAME_H
#define BOWLING_GAME_H

#if 0
#include <stdbool.h>

struct bowling_game;
extern struct bowling_game * bowling_game_create(void);
extern void bowling_game_destroy(struct bowling_game * game);
extern void bowling_game_roll(struct bowling_game * game, int pins);
extern int bowling_game_score(struct bowling_game * game);
#endif

class bowling_game{
private:
    static const int max_rolls = 21;
    int rolls[max_rolls] = { 0,};
    int current_roll = 0;

    bool is_strike(int frame_index);
    bool is_spare(int frame_index);
    int strike_score(int frame_index);
    int spare_score(int frame_index);
    int nomal_score(int frame_index);

public:
    bowling_game();
    ~bowling_game();
    void roll(int);
    int score();
};

#endif
