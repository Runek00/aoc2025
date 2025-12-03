const std = @import("std");
const lib = @import("aocLib.zig");

pub fn a() u64 {
    var banks = lib.fileToTable("day3.txt");
    var output: u64 = 0;
    while (banks.next()) |strBank| {
        var mp = getMaxPos(strBank);
        var mp2: MaxPos = undefined;
        if (mp.position == strBank.len - 1) {
            mp2 = mp;
            mp = getMaxPos(strBank[0 .. strBank.len - 1]);
        } else {
            mp2 = getMaxPos(strBank[mp.position + 1 ..]);
        }
        const bankMax = (mp.value - 48) * 10 + mp2.value - 48;
        output += bankMax;
    }
    return output;
}

pub const MaxPos = struct {
    value: u8,
    position: u32,
};

fn getMaxPos(bank: []const u8) MaxPos {
    var max = bank[0];
    var maxPos: u32 = 0;
    var pos: u32 = 0;

    for (bank) |battery| {
        if (battery == 57) {
            max = battery;
            maxPos = pos;
            break;
        }
        if (battery > max) {
            max = battery;
            maxPos = pos;
        }
        pos += 1;
    }
    return MaxPos{
        .value = max,
        .position = maxPos,
    };
}

pub fn b() u64 {
    var banks = lib.fileToTable("day3.txt");
    var output: u64 = 0;
    while (banks.next()) |strBank| {
        output += joltage(strBank, 12);
    }
    return output;
}

fn joltage(bank: []const u8, numLen: u32) u64 {
    if (bank.len < numLen) {
        return 0;
    }
    var start: u32 = 0;
    var output: u64 = 0;
    for (0..numLen) |pos| {
        const mp = getMaxPos(bank[start .. bank.len - numLen + pos + 1]);
        output *= 10;
        output += mp.value - 48;
        start += mp.position + 1;
    }
    return output;
}
