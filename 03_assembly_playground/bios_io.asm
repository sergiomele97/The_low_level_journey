;
; bios_io.asm - Librería de utilidades para BIOS
;

; Imprime el carácter en AL
print_char:
    push ax         ; Guardamos AX por si acaso
    mov ah, 0x0e
    int 0x10
    pop ax          ; Recuperamos AX
    ret

; Imprime un salto de línea (CR + LF)
print_newline:
    push ax
    mov ah, 0x0e
    mov al, 0x0D    ; Carriage Return (Retorno de carro)
    int 0x10
    mov al, 0x0A    ; Line Feed (Salto de línea)
    int 0x10
    pop ax
    ret

; Lee una tecla del teclado (Bloqueante)
; El resultado ('letra') queda en AL
read_key:
    mov ah, 0x00
    int 0x16
    ret
