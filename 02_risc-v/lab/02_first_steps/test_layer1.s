# RISC-V Layer 1 Test
lui t0, 0x12345      # Tipo-U: t0 = 0x12345000
addi t0, t0, 0x678   # Tipo-I: t0 = t0 + 0x678
addi t1, zero, 10
add t2, t0, t1       # Tipo-R: t2 = t0 + t1
sub t3, t2, t1       # Tipo-R: t3 = t2 - t1
