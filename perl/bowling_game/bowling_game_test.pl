#!/usr/bin/perl
use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin";
use Test::More tests => 5;
use bowling_game;

# テストケース1: 全て0ピン
bowling_game::reset_game();
for (1..20) {
    bowling_game::roll(0);
}
is(bowling_game::score(), 0, 'All zeros');

# テストケース2: 全て1ピン
bowling_game::reset_game();
for (1..20) {
    bowling_game::roll(1);
}
is(bowling_game::score(), 20, 'All ones');

# テストケース3: スペアと3ピン
bowling_game::reset_game();
bowling_game::roll(5);
bowling_game::roll(5); # スペア
bowling_game::roll(3);
for (1..17) {
    bowling_game::roll(0);
}
is(bowling_game::score(), 16, 'Spare followed by 3');

# テストケース4: ストライクと3, 4ピン
bowling_game::reset_game();
bowling_game::roll(10); # ストライク
bowling_game::roll(3);
bowling_game::roll(4);
for (1..16) {
    bowling_game::roll(0);
}
is(bowling_game::score(), 24, 'Strike followed by 3 and 4');

# テストケース5: Perfect game
bowling_game::reset_game();
for (1..12) {
    bowling_game::roll(10);
}
is(bowling_game::score(), 300, 'Perfect game');

done_testing();
