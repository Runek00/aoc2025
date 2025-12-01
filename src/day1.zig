const std = @import("std");
const lib = @import("aocLib.zig");

pub fn a() !u32 {
    var list = lib.fileToTable("day1.txt");
    var cnt: u32 = 0;
    var pos: i32 = 50;

    while (list.next()) |line| {
        if (line.len <= 0) {
            break;
        }
        const ll = line[1..];
        const c = try std.fmt.parseInt(i32, ll, 10);
        var sgn: i2 = undefined;
        if (line[0] == 'L') {
            sgn = -1;
        } else {
            sgn = 1;
        }
        pos = pos + (sgn * c);
        while (pos < 0) {
            pos += 100;
        }
        while (pos > 99) {
            pos -= 100;
        }
        if (pos == 0) {
            cnt += 1;
        }
    }
    return cnt;
}

pub fn b() !u32 {
    var list = lib.fileToTable("day1.txt");
    var cnt: u32 = 0;
    var pos: i32 = 50;

    while (list.next()) |line| {
        if (line.len <= 0) {
            break;
        }
        const ll = line[1..];
        const c = try std.fmt.parseInt(i32, ll, 10);
        var sgn: i2 = undefined;
        if (line[0] == 'L') {
            sgn = -1;
            if (pos == 0) {
                cnt -= 1;
            }
        } else {
            sgn = 1;
        }
        pos = pos + (sgn * c);
        while (pos < 0) {
            pos += 100;
            cnt += 1;
        }
        while (pos > 99) {
            pos -= 100;
            cnt += 1;
        }
        if (sgn == -1 and pos == 0) {
            cnt += 1;
        }
    }
    return cnt;
}
