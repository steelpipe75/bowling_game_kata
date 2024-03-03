#ifndef BOWLING_GAME_H
#define BOWLING_GAME_H

#ifdef _MSC_VER
    #define DLL_EXPORT __declspec(dllexport)
#else
    #define DLL_EXPORT 
#endif

class DLL_EXPORT bowling_game{
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
