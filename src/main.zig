const std = @import("std");
const lib = @import("aocLib.zig");
const day1 = @import("day1.zig");
const day2 = @import("day2.zig");
const day3 = @import("day3.zig");

pub fn main() !void {
    std.debug.print("day1:\n\t a: {any}\n\t b: {any}\n", .{ day1.a(), day1.b() });
    std.debug.print("day2:\n\t a: {any}\n\t b: {any}\n", .{ day2.a(), day2.b() });
    std.debug.print("day3:\n\t a: {any}\n\t b: {any}\n", .{ day3.a(), day3.b() });
}
