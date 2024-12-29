const std = @import("std");
const builtin = @import("builtin");
const arch = builtin.target.cpu.arch;
const features = builtin.cpu.features;

pub const is_aarch64 = arch == .aarch64 or arch == .aarch64_be;

pub const has_neon = is_aarch64 and std.Target.aarch64.featureSetHas(features, .neon);
pub const has_aes = is_aarch64 and std.Target.aarch64.featureSetHas(features, .aes);
pub const has_rdm = is_aarch64 and std.Target.aarch64.featureSetHas(features, .rdm);
pub const has_sha2 = is_aarch64 and std.Target.aarch64.featureSetHas(features, .sha2);
pub const has_sha3 = is_aarch64 and std.Target.aarch64.featureSetHas(features, .sha3);
pub const has_dotprod = is_aarch64 and std.Target.aarch64.featureSetHas(features, .dotprod);
pub const has_i8mm = is_aarch64 and std.Target.aarch64.featureSetHas(features, .i8mm);
pub const has_sm4 = is_aarch64 and std.Target.aarch64.featureSetHas(features, .sm4);
pub const has_crypto = is_aarch64 and std.Target.aarch64.featureSetHas(features, .crypto);
pub const has_sve = is_aarch64 and std.Target.aarch64.featureSetHas(features, .sve);
