pub const aarch64 = @import("arch/aarch64.zig");
pub const arm = @import("arch/arm.zig");
const builtin = @import("builtin");
pub const is_arm = arm.is_arm;
pub const is_aarch64 = aarch64.is_aarch64;
