.macro ESCRIBIR_CARACTER letra
    li t0, 0x10000000
    li t1, \letra
    sb t1, 0(t0)
.endm

.section .text
.globl _start

_start:
    ESCRIBIR_CARACTER 82  # R
    ESCRIBIR_CARACTER 73  # I
    ESCRIBIR_CARACTER 83  # S
    ESCRIBIR_CARACTER 67  # C

loop:
    j loop