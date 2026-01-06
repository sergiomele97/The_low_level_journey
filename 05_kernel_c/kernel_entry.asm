;
; kernel_entry.asm - El puente entre el Bootloader y C
;

[bits 32]
[extern kmain] ; Declare que kmain viene de otro archivo (el .c)

call kmain     ; Llamamos a la función de C
jmp $          ; Bucle infinito si volvemos de C
