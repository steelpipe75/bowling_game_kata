#!/usr/bin/perl
use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin";
use bowling_game;

my $file = shift @ARGV;
die "Usage: $0 <file>\n" unless defined $file;

open my $fh, '<', $file or die "Could not open file '$file': $!\n";

while (my $line = <$fh>) {
    chomp $line;
    last if $line < 0; # 負の数が出たら終了
    bowling_game::roll($line);
}

close $fh;

my $score = bowling_game::score();
print "$score\n";
