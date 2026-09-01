const std = @import("std");

pub inline fn watermark(comptime str: []const u8) void {
    asm volatile (""
        :
        : [param] "" (str),
    );
}

pub fn main() void {
    watermark("omg guys what the fuck");
    std.debug.print("f", .{});
}
