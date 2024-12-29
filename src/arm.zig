const std = @import("std");
const builtin = @import("builtin");
const arch = builtin.target.cpu.arch;
const features = builtin.cpu.features;

pub const is_arm = arch == .arm or arch == .armeb;

pub const has_neon = is_arm and std.Target.arm.featureSetHas(features, .neon);
pub const has_aes = is_arm and std.Target.arm.featureSetHas(features, .aes);
pub const has_sha2 = is_arm and std.Target.arm.featureSetHas(features, .sha2);
pub const has_crc = is_arm and std.Target.arm.featureSetHas(features, .crc);
pub const has_dotprod = is_arm and std.Target.arm.featureSetHas(features, .dotprod);
pub const has_v7 = is_arm and std.Target.arm.featureSetHas(features, .has_v7);
pub const has_v8 = is_arm and std.Target.arm.featureSetHas(features, .has_v8);
pub const has_i8mm = is_arm and std.Target.arm.featureSetHas(features, .i8mm);
