const std = @import("std");

pub fn unparse(int: i64) ![]const u8 {
    var buf: [256]u8 = undefined;
    return try std.fmt.bufPrint(&buf, "{}", .{int});
}

pub fn fileToTable(comptime path: []const u8) std.mem.SplitIterator(u8, .scalar) {
    const file = fileToString(path);
    return std.mem.splitScalar(u8, file, '\n');
}

pub fn fileToString(comptime path: []const u8) []const u8 {
    const file = @embedFile(path);
    if (file[file.len - 1] == '\n') {
        return file[0 .. file.len - 1];
    }
    return file;
}

pub fn tab2DSize(comptime T: type, tab: [][]T) [2]u32 {
    if (tab.len == 0) {
        return []u32{ 0, 0 };
    }
    var y = 0;
    for (tab) |line| {
        if (line.len > y) {
            y = line.len;
        }
    }
    return []u32{ tab.len, y };
}

pub fn gcd(num1: i32, num2: i32) i32 {
    if (num1 == 0 or num2 == 0) {
        return num1 + num2;
    }

    const absN1 = @abs(num1);
    const absN2 = @abs(num2);
    const bigger = @max(absN1, absN2);
    const smaller = @min(absN1, absN2);
    return gcd(bigger % smaller, smaller);
}

pub fn lcm(num1: i32, num2: i32) i32 {
    return @abs(num1 * num2) / gcd(num1, num2);
}

pub const Point = struct {
    a: i32,
    b: i32,

    pub fn add(self: Point, p2: Point) Point {
        return Point{
            .a = self.a + p2.a,
            .b = self.b + p2.b,
        };
    }
};

pub fn point(x: i32, y: i32) Point {
    return Point{
        .a = x,
        .b = y,
    };
}

pub fn pointInBounds(pt: Point, tab: [][]i32) bool {
    return pt.a >= 0 and pt.a < tab.len and pt.b >= 0 and pt.b < tab[1].len;
}

pub const Dir = struct {
    a: i2,
    b: i2,
};

pub fn dir(x: i2, y: i2) Dir {
    return Dir{
        .a = x,
        .b = y,
    };
}

pub const Step = struct {
    a: i32,
    b: i32,
    dir: Dir,
};

pub fn step(a: i32, b: i32, to: Dir) Step {
    return Point{
        .a = a,
        .b = b,
        .dir = to,
    };
}

pub fn stepFromPoint(pt: Point, to: Dir) Step {
    return Step{
        .a = pt.a,
        .b = pt.b,
        .dir = to,
    };
}

pub fn forward(stp: Step) Step {
    return Step{
        .a = stp.a + stp.dir.a,
        .b = stp.b + stp.dir.b,
        .dir = stp.dir,
    };
}

pub const N = dir(-1, 0);
pub const S = dir(1, 0);
pub const E = dir(0, 1);
pub const W = dir(0, -1);

pub fn opposite(direction: Dir) Dir {
    return Dir{
        .a = -direction.a,
        .b = -direction.b,
    };
}

pub fn getAllDirections() [4]Dir {
    return [_]Dir{ N, S, E, W };
}

pub fn compStrings(str1: []const u8, str2: []const u8) bool {
    if (str1.len != str2.len) {
        return false;
    }
    for (0..str1.len) |i| {
        if (str1[i] != str2[i]) {
            return false;
        }
    }
    return true;
}
