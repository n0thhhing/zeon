#include <arm_neon.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

void u8_to_hex_neon(const uint8_t *input, size_t length, char *output) {
  static const uint8_t hex_table[16] = {'0', '1', '2', '3', '4', '5', '6', '7',
                                        '8', '9', 'a', 'b', 'c', 'd', 'e', 'f'};

  // Load hex table into NEON register
  uint8x16_t hex_lookup = vld1q_u8(hex_table);
  uint8x16_t mask_low = vdupq_n_u8(0x0F); // Mask for low nibble

  size_t i = 0;

  // Process 32 bytes per iteration
  for (; i + 32 <= length; i += 32) {
    uint8x16_t input_chunk1 = vld1q_u8(input + i);
    uint8x16_t input_chunk2 = vld1q_u8(input + i + 16);

    // Split bytes into high and low nibbles
    uint8x16_t high_nibbles1 = vshrq_n_u8(input_chunk1, 4);
    uint8x16_t low_nibbles1 = vandq_u8(input_chunk1, mask_low);
    uint8x16_t high_nibbles2 = vshrq_n_u8(input_chunk2, 4);
    uint8x16_t low_nibbles2 = vandq_u8(input_chunk2, mask_low);

    // Lookup high and low nibbles
    uint8x16_t high_chars1 = vqtbl1q_u8(hex_lookup, high_nibbles1);
    uint8x16_t low_chars1 = vqtbl1q_u8(hex_lookup, low_nibbles1);
    uint8x16_t high_chars2 = vqtbl1q_u8(hex_lookup, high_nibbles2);
    uint8x16_t low_chars2 = vqtbl1q_u8(hex_lookup, low_nibbles2);

    // Interleave high and low hex characters
    uint8x16x2_t interleaved1 = vzipq_u8(high_chars1, low_chars1);
    uint8x16x2_t interleaved2 = vzipq_u8(high_chars2, low_chars2);

    // Store the interleaved results
    vst1q_u8((uint8_t *)(output + i * 2), interleaved1.val[0]);
    vst1q_u8((uint8_t *)(output + i * 2 + 16), interleaved1.val[1]);
    vst1q_u8((uint8_t *)(output + i * 2 + 32), interleaved2.val[0]);
    vst1q_u8((uint8_t *)(output + i * 2 + 48), interleaved2.val[1]);
  }

  // Handle remaining bytes (scalar)
  // Handle remaining bytes (scalar or small NEON processing)
  size_t remaining = length - i;
  if (remaining >= 16) {
    uint8x16_t input_chunk = vld1q_u8(input + i);

    // Split bytes into high and low nibbles
    uint8x16_t high_nibbles = vshrq_n_u8(input_chunk, 4);
    uint8x16_t low_nibbles = vandq_u8(input_chunk, mask_low);

    // Lookup high and low nibbles in the hex table
    uint8x16_t high_chars = vqtbl1q_u8(hex_lookup, high_nibbles);
    uint8x16_t low_chars = vqtbl1q_u8(hex_lookup, low_nibbles);

    // Interleave the high and low hex characters
    uint8x16x2_t interleaved = vzipq_u8(high_chars, low_chars);

    // Store the result
    vst1q_u8((uint8_t *)(output + i * 2), interleaved.val[0]);
    vst1q_u8((uint8_t *)(output + i * 2 + 16), interleaved.val[1]);

    i += 16;
  }

  // Process any remaining bytes scalar-wise
  for (; i < length; i++) {
    uint8_t byte = input[i];
    output[i * 2] = hex_table[byte >> 4];
    output[i * 2 + 1] = hex_table[byte & 0x0F];
  }

  // Null-terminate the output string
  output[length * 2] = '\0';
}

int main() {
  const char *filename = "./new.so";

  FILE *file = fopen(filename, "rb");
  if (!file) {
    perror("Failed to open file");
    return 1;
  }

  // Get file size
  fseek(file, 0, SEEK_END);
  size_t filesize = ftell(file);
  rewind(file);

  // Allocate memory for file contents and read the file
  uint8_t *buffer = malloc(filesize);
  if (!buffer) {
    perror("Failed to allocate memory");
    fclose(file);
    return 1;
  }

  if (fread(buffer, 1, filesize, file) != filesize) {
    perror("Failed to read file");
    free(buffer);
    fclose(file);
    return 1;
  }
  fclose(file);

  // Allocate memory for the hex output
  char *hex_output =
      malloc(filesize * 2 + 1); // Each byte -> 2 hex chars + null terminator
  if (!hex_output) {
    perror("Failed to allocate memory for hex output");
    free(buffer);
    return 1;
  }

  // Convert to hex
  clock_t conversion_start = clock(); // Start timing the conversion
  u8_to_hex_neon(buffer, filesize, hex_output);
  clock_t conversion_end = clock(); // End timing the conversion

  double conversion_time =
      (double)(conversion_end - conversion_start) / CLOCKS_PER_SEC;
  printf("Conversion time: %.6f seconds\n", conversion_time);
  // Print the hex output
  printf("%s\n", hex_output);

  // Cleanup
  free(buffer);
  free(hex_output);

  return 0;
}
