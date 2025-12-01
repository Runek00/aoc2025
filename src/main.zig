const std = @import("std");
const lib = @import("aocLib.zig");
const day1 = @import("day1.zig");

pub fn main() !void {
    std.debug.print("day1:\n\t a: {any}\n\t b: {any}\n", .{ day1.a(), day1.b() });
}
