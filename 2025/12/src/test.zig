const std = @import("std");
const testing = std.testing;

const lib = @import("lib");

const data = [_][]const u8{
    "0:",
    "###",
    "##.",
    "##.",
    "",
    "1:",
    "###",
    "##.",
    ".##",
    "",
    "2:",
    ".##",
    "###",
    "##.",
    "",
    "3:",
    "##.",
    "###",
    "##.",
    "",
    "4:",
    "###",
    "#..",
    "###",
    "",
    "5:",
    "###",
    ".#.",
    "###",
    "",
    "4x4: 0 0 0 0 2 0",
    "12x5: 1 0 1 0 2 2",
    "12x5: 1 0 1 0 3 2",
};

test "First" {
    const first_expected = 2;
    const first_actual = try lib.first(&data, testing.allocator);
    try testing.expectEqual(first_expected, first_actual);
}

test "Second" {
    const second_expected = 2;
    const second_actual = try lib.second(&data);
    try testing.expectEqual(second_expected, second_actual);
}
