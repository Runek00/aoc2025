const std = @import("std");
const lib = @import("aocLib.zig");

pub fn a() !u64 {
    const path = "day2.txt";
    const str = lib.fileToString(path);
    var ranges = std.mem.splitScalar(u8, str, ',');
    var output: u64 = 0;
    while (ranges.next()) |range| {
        var tmp = std.mem.splitScalar(u8, range, '-');
        const r1: u64 = try std.fmt.parseInt(u64, tmp.next().?, 10);
        const r2: u64 = try std.fmt.parseInt(u64, tmp.next().?, 10);
        for (r1..r2 + 1) |num| {
            const n: u64 = @intCast(num);
            const length: u64 = @intCast(std.math.log10(n) + 1);
            if (@mod(length, 2) == 1) {
                continue;
            }
            const tens = std.math.pow(u64, 10, length / 2);
            const left = @divFloor(n, tens);
            const right = @mod(n, tens);
            if (left == right) {
                output += n;
            }
        }
    }
    return output;
}

pub fn b() !u64 {
    const path = "day2.txt";
    const str = lib.fileToString(path);
    var ranges = std.mem.splitScalar(u8, str, ',');
    var output: u64 = 0;
    while (ranges.next()) |range| {
        var tmp = std.mem.splitScalar(u8, range, '-');
        const r1: u64 = try std.fmt.parseInt(u64, tmp.next().?, 10);
        const r2: u64 = try std.fmt.parseInt(u64, tmp.next().?, 10) + 1;
        for (r1..r2) |num| {
            const n: u64 = @intCast(num);
            const length: u64 = std.math.log10(n) + 1;
            if (length == 1) {
                continue;
            }
            for (1..length / 2 + 1) |l| {
                const ll: u64 = @intCast(l);
                if (length % ll != 0) {
                    continue;
                }
                if (isInvalid(n, length, ll)) {
                    output += n;
                    break;
                }
            }
        }
    }
    return output;
}

fn isInvalid(num: u64, length: u64, l: u64) bool {
    var n = num;
    const outSize = length / l;
    const tens = std.math.pow(u64, 10, l);
    var last: u64 = 0;
    for (0..outSize) |i| {
        const cur = @mod(n, tens);
        n = @divFloor(n, tens);
        if (i > 0 and cur != last) {
            return false;
        }
        last = cur;
    }
    return true;
}
