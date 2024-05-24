const std = @import("std");
const BowlingGame = @import("bowling_game.zig").BowlingGame;

test "All zero game" {
    var bg = BowlingGame.init();
    for (0..20) |_| {
        bg.roll(0);
    }
    try std.testing.expect(bg.score() == 0);
}

test "All ones game" {
    var bg = BowlingGame.init();
    for (0..20) |_| {
        bg.roll(1);
    }
    try std.testing.expect(bg.score() == 20);
}

test "one spare game" {
    var bg = BowlingGame.init();
    bg.roll(5);
    bg.roll(5);
    bg.roll(3);
    for (0..17) |_| {
        bg.roll(0);
    }
    try std.testing.expect(bg.score() == 16);
}

test "one strike game" {
    var bg = BowlingGame.init();
    bg.roll(10);
    bg.roll(3);
    bg.roll(4);
    for (0..16) |_| {
        bg.roll(0);
    }
    try std.testing.expect(bg.score() == 24);
}

test "perfect game" {
    var bg = BowlingGame.init();
    for (0..12) |_| {
        bg.roll(10);
    }
    try std.testing.expect(bg.score() == 300);
}
