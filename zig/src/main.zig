const std = @import("std");
const fs = std.fs;
const BowlingGame = @import("lib/bowling_game.zig").BowlingGame;

pub fn main() !void {
    const allocator = std.heap.page_allocator;
    const args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);

    if (args.len != 2) {
        std.debug.print("Usage: {s} <input_file>\n", .{args[0]});
        return;
    }
    const inputFileName = args[1];
    const file = fs.cwd().openFile(inputFileName, .{}) catch {
        std.debug.print("Failed to open file: {s}\n", .{inputFileName});
        return;
    };
    defer file.close();

    var bg = BowlingGame.init();

    var buf_reader = std.io.bufferedReader(file.reader());
    var in_stream = buf_reader.reader();

    var buf: [1024]u8 = undefined;
    while (try in_stream.readUntilDelimiterOrEof(&buf, '\n')) |line| {
        // std.debug.print("line {s}\n", .{line});
        const result = try std.fmt.parseInt(i32, line, 10);
        if (result < 0) {
            break;
        }
        // std.debug.print("roll {any}\n", .{result});
        bg.roll(@as(u8, @intCast(result)));
    }

    const finalScore = bg.score();
    std.debug.print("{any}\n", .{finalScore});
}
