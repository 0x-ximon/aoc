const std = @import("std");

pub fn first(data: []const []const u8, allocator: std.mem.Allocator) !u64 {
    var result: u64 = 0;

    const Present = struct { area: u64 = 0, shape: [3]std.bit_set.Integer(3) };
    var presents: [6]Present = std.mem.zeroes([6]Present);

    const Region = struct { width: u64, height: u64, amounts: [6]u64 };
    var regions: std.ArrayList(Region) = .empty;
    defer regions.deinit(allocator);

    var p: u8 = 1;
    var q: u8 = 4;

    for (0..6) |i| {
        for (p..q, 0..3) |r, j| {
            const row = data[r];

            for (0..3) |k| {
                if (row[k] == '#') {
                    presents[i].area += 1;
                    presents[i].shape[j].set(k);
                }
            }
        }

        p += 5;
        q += 5;
    }

    for (p - 1..data.len) |i| {
        const row = data[i];
        if (row.len == 0) continue;

        var dimensions: [2]u64 = undefined;
        var amounts: [6]u64 = undefined;

        var iter = std.mem.splitSequence(u8, row, " ");
        const meta = iter.first();
        {
            var it = std.mem.splitSequence(u8, meta, "x");
            var j: u8 = 0;

            while (it.next()) |chunk| {
                const buffer = std.mem.trimEnd(u8, chunk, ":");
                dimensions[j] = try std.fmt.parseInt(u8, buffer, 10);
                j += 1;
            }
        }

        {
            var j: u8 = 0;
            while (iter.next()) |index| {
                amounts[j] = try std.fmt.parseInt(u8, index, 10);
                j += 1;
            }
        }

        try regions.append(allocator, .{
            .width = dimensions[0],
            .height = dimensions[1],
            .amounts = amounts,
        });
    }

    for (regions.items) |region| {
        const capacity: u64 = region.height * region.width;

        // Check if region could hold every present if they were fully filled
        {
            const full = 9;
            var required: u64 = 0;

            for (region.amounts) |amount| {
                required += full * amount;
            }

            if (required < capacity) {
                result += 1;
                continue;
            }
        }

        // Check if region could hold every present assumming they were perfectly rotated
        {
            var required: u64 = 0;

            for (region.amounts, 0..) |amount, i| {
                const present = presents[i];
                required += present.area * amount;
            }

            if (required < capacity) {
                result += 1;
                continue;
            }
        }
    }

    return result;
}

pub fn second(_: []const []const u8) !u64 {
    const result: u64 = 0;

    return result;
}
