# Hex Assembler v0 - Design Document
# This file contains the pseudo-assembly design before encoding to hex

## Constants
# UART_BASE = 0x10000000
# USER_CODE_BUFFER = 0x80000200
# PROMPT_CHAR = '>' = 0x3E

## Register Allocation
# s0 (x8)  = UART base (0x10000000)
# s1 (x9)  = User code write pointer (starts at 0x80000200)
# t0 (x5)  = Temp for operations
# t1 (x6)  = Temp for operations
# t2 (x7)  = Temp for operations
# a0 (x10) = Function argument/return value
# a1 (x11) = Function argument
# ra (x1)  = Return address

#========================================
# MAIN PROGRAM START
#========================================
_start:
    # Initialize UART base
    lui s0, 0x10000          # s0 = 0x10000000
    
    # Initialize user code buffer pointer
    lui s1, 0x80000          # s1 = 0x80000000
    addi s1, s1, 0x200       # s1 = 0x80000200
    
    # Fall through to main_loop

#========================================
# MAIN LOOP
#========================================
main_loop:
    # Print prompt '>'
    addi a0, zero, 0x3E      # a0 = '>'
    jal ra, uart_putchar
    
    addi a0, zero, 0x20      # a0 = ' ' (space)
    jal ra, uart_putchar

input_loop:
    # Read character
    jal ra, uart_getchar     # Returns char in a0
    
    # Check if newline (0x0A) or carriage return (0x0D)
    addi t0, zero, 0x0A
    beq a0, t0, execute_code
    
    addi t0, zero, 0x0D
    beq a0, t0, execute_code
    
    # Check if space (0x20) - skip it
    addi t0, zero, 0x20
    beq a0, t0, input_loop
    
    # Otherwise, assume it's a hex digit
    # Convert first nibble
    addi t1, a0, 0           # Save first char in t1
    jal ra, hex_to_nibble    # Convert a0 to nibble
    
    # Check if valid (result >= 0)
    bltz a0, input_loop      # If negative, skip
    
    # Shift left by 4 to make room for second nibble
    slli t2, a0, 4           # t2 = first_nibble << 4
    
    # Read second character
    jal ra, uart_getchar
    jal ra, hex_to_nibble
    
    # Check if valid
    bltz a0, input_loop
    
    # Combine: byte = (first << 4) | second
    or t2, t2, a0            # t2 = complete byte
    
    # Write byte to user buffer
    sb t2, 0(s1)             # Store byte at current position
    addi s1, s1, 1           # Increment write pointer
    
    # Continue reading
    jal zero, input_loop

execute_code:
    # Reset write pointer to start of buffer
    lui s1, 0x80000
    addi s1, s1, 0x200
    
    # Jump to user code
    jalr zero, s1, 0         # Jump to 0x80000200 (no return)

#========================================
# FUNCTION: uart_getchar
# Returns: character in a0
#========================================
uart_getchar:
    lbu t0, 5(s0)            # Read LSR
    andi t0, t0, 1           # Check bit 0
    beq t0, zero, uart_getchar  # Loop if not ready
    lbu a0, 0(s0)            # Read character
    jalr zero, ra, 0         # Return

#========================================
# FUNCTION: uart_putchar
# Input: character in a0
#========================================
uart_putchar:
    sb a0, 0(s0)             # Write to UART
    jalr zero, ra, 0         # Return

#========================================
# FUNCTION: hex_to_nibble
# Input: ASCII character in a0
# Output: 0-15 in a0, or -1 if invalid
#========================================
hex_to_nibble:
    # Check if '0' <= a0 <= '9'
    addi t0, zero, 0x30      # '0'
    blt a0, t0, check_upper  # if a0 < '0', try uppercase
    
    addi t0, zero, 0x39      # '9'
    bgt a0, t0, check_upper  # if a0 > '9', try uppercase
    
    # It's '0'-'9', return a0 - '0'
    addi a0, a0, -0x30
    jalr zero, ra, 0

check_upper:
    # Check if 'A' <= a0 <= 'F'
    addi t0, zero, 0x41      # 'A'
    blt a0, t0, check_lower
    
    addi t0, zero, 0x46      # 'F'
    bgt a0, t0, check_lower
    
    # It's 'A'-'F', return a0 - 'A' + 10
    addi a0, a0, -0x37       # -'A' + 10 = -55 = -0x37
    jalr zero, ra, 0

check_lower:
    # Check if 'a' <= a0 <= 'f'
    addi t0, zero, 0x61      # 'a'
    blt a0, t0, invalid_char
    
    addi t0, zero, 0x66      # 'f'
    bgt a0, t0, invalid_char
    
    # It's 'a'-'f', return a0 - 'a' + 10
    addi a0, a0, -0x57       # -'a' + 10 = -87 = -0x57
    jalr zero, ra, 0

invalid_char:
    addi a0, zero, -1        # Return -1
    jalr zero, ra, 0
