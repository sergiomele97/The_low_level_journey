# Hex Assembler v0 - SIMPLIFIED VERSION
# Manual hex encoding - keeping it minimal for first version

## Simplified Design
# This version will be much simpler:
# 1. Read hex pairs (no spaces, just continuous stream)
# 2. Write to buffer at 0x80000200
# 3. Execute when 'X' is pressed

## Register Usage
# s0 = UART base (0x10000000)
# s1 = Write pointer (starts at 0x80000200)
# t0, t1, t2 = temps
# a0 = char/return value

_start:
    # s0 = 0x10000000 (UART)
    lui s0, 0x10000          # 0x00: 37 04 00 10

    # s1 = 0x80000200 (buffer)
    lui s1, 0x80000          # 0x04: B7 04 00 80
    addi s1, s1, 0x200       # 0x08: 93 84 04 20

main_loop:
    # Print '>' prompt
    addi a0, zero, 62        # 0x0C: 13 05 E0 03 (62 = 0x3E)
    sb a0, 0(s0)             # 0x10: 23 80 A4 00
    
    # Print ' ' space  
    addi a0, zero, 32        # 0x14: 13 05 00 02
    sb a0, 0(s0)             # 0x18: 23 80 A4 00

read_loop:
    # Wait for character (polling)
    lbu t0, 5(s0)            # 0x1C: 03 C2 54 00
    andi t0, t0, 1           # 0x20: 93 72 12 00
    beq t0, zero, -8         # 0x24: E3 0C 02 FE
    
    # Read character
    lbu a0, 0(s0)            # 0x28: 03 C5 04 00
    
    # Check if 'X' (execute command)
    addi t0, zero, 88        # 0x2C: 93 02 80 05 (88 = 0x58 = 'X')
    beq a0, t0, execute      # 0x30: 63 08 55 00
    
    # Convert first hex digit
    addi t1, a0, 0           # 0x34: 93 03 05 00 (save char)
    jal ra, hex_to_nib       # 0x38: EF 00 00 03 (offset calculated later)
    slli a0, a0, 4           # 0x3C: 13 15 45 00 (shift to upper nibble)
    addi t2, a0, 0           # 0x40: 93 93 05 00 (save upper nibble)
    
    # Read second hex digit
    # polling
    lbu t0, 5(s0)            # 0x44: 03 C2 54 00
    andi t0, t0, 1           # 0x48: 93 72 12 00
    beq t0, zero, -8         # 0x4C: E3 0C 02 FE
    lbu a0, 0(s0)            # 0x50: 03 C5 04 00
    
    jal ra, hex_to_nib       # 0x54: EF 00 00 02 (offset calculated later)
    
    # Combine nibbles
    or a0, t2, a0            # 0x58: 33 65 A3 00
    
    # Store byte
    sb a0, 0(s1)             # 0x5C: 23 80 A4 00
    addi s1, s1, 1           # 0x60: 93 84 14 00
    
    # Loop
    jal zero, read_loop      # 0x64: 6F F0 7F FB

execute:
    # Reset pointer
    lui s1, 0x80000          # 0x68: B7 04 00 80
    addi s1, s1, 0x200       # 0x6C: 93 84 04 20
    
    # Jump to user code
    jalr zero, s1, 0         # 0x70: 67 00 04 00

# hex_to_nibble function
# Input: ASCII in a0
# Output: 0-15 in a0
hex_to_nib:
    # if >= '0' and <= '9', return a0 - '0'
    addi t0, zero, 48        # 0x74: 93 02 00 03 ('0' = 48)
    blt a0, t0, try_upper    # 0x78: 63 4C 52 00
    addi t0, zero, 57        # 0x7C: 93 02 90 03 ('9' = 57)
    bgt a0, t0, try_upper    # 0x80: 63 5C 52 00
    addi a0, a0, -48         # 0x84: 13 05 05 FD
    jalr zero, ra, 0         # 0x88: 67 80 00 00

try_upper:
    # if >= 'A' and <= 'F', return a0 - 'A' + 10
    addi t0, zero, 65        # 0x8C: 93 02 10 04 ('A' = 65)
    blt a0, t0, try_lower    # 0x90: 63 4C 52 00
    addi t0, zero, 70        # 0x94: 93 02 60 04 ('F' = 70)
    bgt a0, t0, try_lower    # 0x98: 63 5C 52 00
    addi a0, a0, -55         # 0x9C: 13 05 95 FC
    jalr zero, ra, 0         # 0xA0: 67 80 00 00

try_lower:
    # if >= 'a' and <= 'f', return a0 - 'a' + 10
    addi t0, zero, 97        # 0xA4: 93 02 10 06 ('a' = 97)
    blt a0, t0, invalid      # 0xA8: 63 4C 52 00
    addi t0, zero, 102       # 0xAC: 93 02 60 06 ('f' = 102)
    bgt a0, t0, invalid      # 0xB0: 63 5C 52 00
    addi a0, a0, -87         # 0xB4: 13 05 95 FA
    jalr zero, ra, 0         # 0xB8: 67 80 00 00

invalid:
    addi a0, zero, 0         # 0xBC: 13 05 00 00
    jalr zero, ra, 0         # 0xC0: 67 80 00 00
