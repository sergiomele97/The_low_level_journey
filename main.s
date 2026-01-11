.section .text

.global main
main:
    lui t0, 0x10000 # Load UART base address into t0
    li a7, 94     # Syscall number for exit
    ecall         # Exit program
