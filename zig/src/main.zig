const std = @import("std");

pub fn main() !void {
    const alc = std.heap.page_allocator;
    const args = try std.process.argsAlloc(alc);
    defer std.process.argsFree(alc, args);

    if (args.len < 2) {
        std.debug.print("Usage: {s} decimal_numbers ..\n", .{args[0]});
        std.os.exit(1);
    }
    var sum: i32 = 0;
    for (args[1..]) |a| {
        const arg = std.mem.sliceTo(a, 0);
        const num = try std.fmt.parseInt(i32, arg, 10);
        sum += num;
    }
    const stdout = std.io.getStdOut().writer();
    try stdout.print("{d}\n", .{sum});
}
