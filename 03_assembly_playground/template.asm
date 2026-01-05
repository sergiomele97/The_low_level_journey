;
; Assembly Playground Template
; Usa este archivo para resolver los retos.
; Compilar: nasm -f bin template.asm -o boot.bin
; Ejecutar: qemu-system-x86_64 boot.bin
;

[org 0x7c00]

%include "bios_io.asm"  ; Importamos nuestra nueva "librería"

    ; --- TU CÓDIGO EMPIEZA AQUÍ ---

    ; Ejercicio 1: printear mi inicial
    mov ah, 0x0e    ; Modo teletipo de la BIOS
    mov al, 'S'     ; Poner una letra en AL
    int 0x10        ; Imprimirla

    ; Ejercicio 2: suma invisible
    mov ah, 0x0e
    mov al, '1'
    add al, 1
    int 0x10

    ; Voy a probar a hacer un if    
    CMP al, '2'
    JNE no_imprimir
    mov al, '='
    int 0x10 

no_imprimir:
    
    ; Ejercicio 3: Contraseña simple



    ; Reto: Intenta sumar dos números o leer una tecla aquí.

    ; --- TU CÓDIGO TERMINA AQUÍ ---

hang:
    jmp hang        ; Bucle infinito para que la CPU no se escape

; Relleno sagrado (No tocar)
times 510-($-$$) db 0
dw 0xaa55
