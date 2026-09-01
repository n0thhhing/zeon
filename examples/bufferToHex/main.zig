const std = @import("std");
const neon = @import("zeon");

const hex_lookup: neon.u8x16 = .{ '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f' };
const mask_low: neon.u8x16 = @splat(0x0f);

fn buftohex(input: [*]const u8, output: [*]u8, comptime len: usize) void {
    comptime var i: usize = 0;
    inline while (i + 32 <= len) : (i += 32) {
        const input_chunk1 = neon.vld1q_u8(input + i);
        const input_chunk2 = neon.vld1q_u8(input + i + 16);

        // Split bytes into high and low nibbles
        const high_nibbles1 = neon.vshrq_n_u8(input_chunk1, 4);
        const low_nibbles1 = neon.vandq_u8(input_chunk1, mask_low);
        const high_nibbles2 = neon.vshrq_n_u8(input_chunk2, 4);
        const low_nibbles2 = neon.vandq_u8(input_chunk2, mask_low);

        // Lookup high and low nibbles
        const high_chars1 = neon.vqtbl1q_u8(hex_lookup, high_nibbles1);
        const low_chars1 = neon.vqtbl1q_u8(hex_lookup, low_nibbles1);
        const high_chars2 = neon.vqtbl1q_u8(hex_lookup, high_nibbles2);
        const low_chars2 = neon.vqtbl1q_u8(hex_lookup, low_nibbles2);

        // Interleave high and low hex characters
        const interleaved1 = neon.vzipq_u8(high_chars1, low_chars1);
        const interleaved2 = neon.vzipq_u8(high_chars2, low_chars2);

        // Store the interleaved results
        neon.vst1q_u8(output + i * 2, interleaved1[0]);
        neon.vst1q_u8(output + i * 2 + 16, interleaved1[1]);
        neon.vst1q_u8(output + i * 2 + 32, interleaved2[0]);
        neon.vst1q_u8(output + i * 2 + 48, interleaved2[1]);
    }

    const remaining = len - i;
    if (remaining >= 16) {
        const input_chunk = neon.vld1q_u8(input + i);

        // Split bytes into high and low nibbles
        const high_nibbles = neon.vshrq_n_u8(input_chunk, 4);
        const low_nibbles = neon.vandq_u8(input_chunk, mask_low);

        // Lookup high and low nibbles in the hex table
        const high_chars = neon.vqtbl1q_u8(hex_lookup, high_nibbles);
        const low_chars = neon.vqtbl1q_u8(hex_lookup, low_nibbles);

        // Interleave the high and low hex characters
        const interleaved = neon.vzipq_u8(high_chars, low_chars);

        // Store the result
        neon.vst1q_u8(output + i * 2, interleaved[0]);
        neon.vst1q_u8(output + i * 2 + 16, interleaved[1]);

        i += 16;
    }

    inline while (i < len) : (i += 1) {
        const byte = input[i];
        output[i * 2] = hex_lookup[byte >> 4];
        output[i * 2 + 1] = hex_lookup[byte & 0x0F];
    }
}

test buftohex {
    const buf: [32]u8 = .{
        0x0c, 0x62, 0x68, 0xf8,
        0x71, 0x29, 0xd7, 0x64,
        0xac, 0x73, 0xf7, 0x7b,
        0x1a, 0x4f, 0x95, 0xf5,
        0x16, 0x67, 0x83, 0xa7,
        0xe4, 0x1e, 0xfc, 0x83,
        0x02, 0xf6, 0x10, 0x30,
        0xee, 0xcc, 0x63, 0xee,
    };
    const expected = "0c6268f87129d764ac73f77b1a4f95f5166783a7e41efc8302f61030eecc63ee";

    var result: [64]u8 = undefined;
    buftohex(buf[0..].ptr, result[0..].ptr, 32);

    try std.testing.expectEqualStrings(expected, &result);
}

pub fn main() void {
    std.debug.print("Buffer to Hex:\n", .{});
    const buf: [32]u8 = .{
        0xb1, 0x35, 0xf9, 0xff,
        0x16, 0x49, 0xb6, 0x49,
        0xa3, 0x4e, 0xf7, 0x7c,
        0xff, 0xd7, 0xf7, 0x57,
        0x5e, 0x7d, 0xe1, 0xb4,
        0x7f, 0x84, 0x52, 0xc3,
        0x62, 0x9b, 0x6a, 0xd3,
        0xc6, 0x67, 0xab, 0xbe,
    };
    var result: [64]u8 = undefined;
    // b135f9ff1649b649a34ef77cffd7f7575e7de1b47f8452c3629b6ad3c667abbe
    buftohex(buf[0..].ptr, result[0..].ptr, 32);
    std.debug.print("{s}\n", .{result});
}
