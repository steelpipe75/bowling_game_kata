package bowling_game;

use strict;
use warnings;

my @rolls = ();
my $current_roll = 0;

sub roll {
    my $pins = shift;
    push @rolls, $pins;
}

sub score {
    my $score = 0;
    my $frame_index = 0;

    for my $frame (1..10) {
        if (is_strike($frame_index)) { # strike
            $score += 10 + strike_bonus($frame_index);
            $frame_index++;
        } elsif (is_spare($frame_index)) { # spare
            $score += 10 + spare_bonus($frame_index);
            $frame_index += 2;
        } else {
            $score += sum_of_balls_in_frame($frame_index);
            $frame_index += 2;
        }
    }

    return $score;
}

sub is_strike {
    my $frame_index = shift;
    return $rolls[$frame_index] == 10;
}

sub is_spare {
    my $frame_index = shift;
    return $rolls[$frame_index] + $rolls[$frame_index + 1] == 10;
}

sub strike_bonus {
    my $frame_index = shift;
    return $rolls[$frame_index + 1] + $rolls[$frame_index + 2];
}

sub spare_bonus {
    my $frame_index = shift;
    return $rolls[$frame_index + 2];
}

sub sum_of_balls_in_frame {
    my $frame_index = shift;
    return $rolls[$frame_index] + $rolls[$frame_index + 1];
}

sub reset_game {
    @rolls = ();
    $current_roll = 0;
}

1;
