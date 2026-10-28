const std = @import("std");
const Io = std.Io;
const Dir = Io.Dir;

const lib = @import("lib");

pub fn main(init: std.process.Init) !void {
    const io = init.io;
    const gpa = init.gpa;

    const buffer = try Dir.cwd().readFileAlloc(io, "input.txt", gpa, .unlimited);
    defer gpa.free(buffer);

    var data: std.ArrayList([]const u8) = .empty;
    defer data.deinit(gpa);

    var iter = std.mem.splitSequence(u8, buffer, "\n");
    while (iter.next()) |chunk| try data.append(gpa, chunk);

    const first_answer = try lib.first(data.items, gpa);
    std.log.info("First Answer: {}", .{first_answer});

    const second_answer = try lib.second(data.items);
    std.log.info("Second Answer: {}", .{second_answer});
}
