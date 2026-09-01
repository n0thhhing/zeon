const neon = @import("zeon");

// Arithmetic
export fn test_vadd_u8(a: neon.uint8x8_t, b: neon.uint8x8_t) neon.uint8x8_t {
    return neon.vadd_u8(a, b);
}

// Crypto
export fn test_aese(data: neon.uint8x16_t, key: neon.uint8x16_t) neon.uint8x16_t {
    return neon.vaeseq_u8(data, key);
}

// Load
export fn test_vld1_u8(ptr: [*]const u8) neon.uint8x8_t {
    return neon.vld1_u8(ptr);
}

// Bitwise
export fn test_vand_u32(a: neon.uint32x2_t, b: neon.uint32x2_t) neon.uint32x2_t {
    return neon.vand_u32(a, b);
}

// Compare
export fn test_vceq_s16(a: neon.int16x4_t, b: neon.int16x4_t) neon.uint16x4_t {
    return neon.vceq_s16(a, b);
}

// Permute
export fn test_vrev64q_s8(a: neon.int8x16_t) neon.int8x16_t {
    return neon.vrev64q_s8(a);
}
