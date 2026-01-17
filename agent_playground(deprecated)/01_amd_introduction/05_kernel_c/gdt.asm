;
; gdt.asm - Global Descriptor Table
;

gdt_start:

gdt_null:            ; El descriptor nulo (obligatorio)
    dd 0x0           ; 'dd' significa Define Double-word (4 bytes)
    dd 0x0

gdt_code:            ; El descriptor del segmento de código
    ; base=0x0, limit=0xfffff , 
    ; 1st flags: (present)1 (privilege)00 (type)1 -> 1001b
    ; type flags: (code)1 (conforming)0 (readable)1 (accessed)0 -> 1010b
    ; 2nd flags: (granularity)1 (32-bit default)1 (64-bit seg)0 (AVL)0 -> 1100b
    dw 0xffff       ; Limit (bits 0-15)
    dw 0x0          ; Base (bits 0-15)
    db 0x0          ; Base (bits 16-23)
    db 10011010b    ; 1st flags , type flags
    db 11001111b    ; 2nd flags , Limit (bits 16-19)
    db 0x0          ; Base (bits 24-31)

gdt_data:            ; El descriptor del segmento de datos
    ; Igual que el de código pero con el bit de 'code' a 0
    ; type flags: (code)0 (expand down)0 (writable)1 (accessed)0 -> 0010b
    dw 0xffff       ; Limit (bits 0-15)
    dw 0x0          ; Base (bits 0-15)
    db 0x0          ; Base (bits 16-23)
    db 10010010b    ; 1st flags , type flags
    db 11001111b    ; 2nd flags , Limit (bits 16-19)
    db 0x0          ; Base (bits 24-31)

gdt_end:

; Descriptor de la GDT (lo que pasaremos a la instrucción lgdt)
gdt_descriptor:
    dw gdt_end - gdt_start - 1 ; Tamaño de la GDT (menos 1)
    dd gdt_start               ; Dirección de inicio de la GDT

; Definimos algunas constantes para los offsets de los segmentos
CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start
