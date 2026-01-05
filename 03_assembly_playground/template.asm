;
; Assembly Playground Template
; Usa este archivo para resolver los retos.
; Compilar: nasm -f bin template.asm -o boot.bin
; Ejecutar: qemu-system-x86_64 boot.bin
;

[org 0x7c00]

    ; comento esto: %include "bios_io.asm"  ; Importamos nuestra nueva "librería"

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

    mov ah, 0x00    ; Leer tecla
    int 0x16        ; 

    CMP al, 'l'
    JNE incorrecta
    mov ah, 0x0e
    mov al, 'S'
    int 0x10 
    jmp fin

incorrecta:
    mov ah, 0x0e
    mov al, 'N'
    int 0x10 
fin:

    ; Ejercicio 4: Convertir minúsculas a mayúsculas

bucle_conversion:
    mov ah, 0x00    ; Leer teclado
    int 0x16

    ; FILTRO: ¿Es una letra minúscula?
    cmp al, 'a'     ; Comparamos con 97 ('a')
    jl imprimir     ; Si es MENOR que 'a', no es minúscula. Saltamos.
    
    cmp al, 'z'     ; Comparamos con 122 ('z')
    jg imprimir     ; Si es MAYOR que 'z', no es minúscula. Saltamos.

    ; Si hemos llegado aquí, es una minúscula (entre 'a' y 'z')
    cmp al, 'q'
    je salir_del_bucle     ; Si es MAYOR que 'z', no es minúscula. Saltamos.
    sub al, 0x20    ; Convertimos a Mayúscula

imprimir:
    mov ah, 0x0e    ; Preparar BIOS para imprimir
    int 0x10
    jmp bucle_conversion

salir_del_bucle:
    call print_newline
    
    ; Ejercicio 5: Contador

    mov ah, 0x0e    ; Preparar BIOS para imprimir
    mov al, '0'
    int 0x10

bucle_contador:
    inc al
    int 0x10
    cmp al, '9'
    je fin_contador
    jmp bucle_contador

fin_contador:
    call print_newline


; Ejecicio finl: suma interactiva


    mov ah, 0x00    ; Leer teclado
    int 0x16
    sub al, '0'
    mov [num1], al
    

    mov ah, 0x00    ; Leer teclado
    int 0x16
    sub al, '0'
    mov [num2], al
    

    mov al, [num1]
    add al, [num2]

    ; Lógica para imprimir números > 9
    mov ah, 0       ; Limpiamos AH para que AX sea exactamente nuestro número
    mov cl, 10
    div cl          ; AX / 10 -> AL = Cociente (Decenas), AH = Resto (Unidades)

    mov cl, ah      ; Guardamos las unidades en CL un momento
    
    ; 1. ¿Hay decenas?
    cmp al, 0
    je .unidades    ; Si decenas == 0, saltamos a las unidades
    
    add al, '0'     ; Convertir decenas a ASCII
    mov ah, 0x0e
    int 0x10        ; Imprimir decena

.unidades:
    mov al, cl      ; Recuperar unidades
    add al, '0'     ; Convertir a ASCII
    mov ah, 0x0e
    int 0x10        ; Imprimir unidad


    ; Reto: Intenta sumar dos números o leer una tecla aquí.

    ; --- TU CÓDIGO TERMINA AQUÍ ---


jmp hang
%include "bios_io.asm" 

num1: db 0
num2: db 0

hang:
    jmp hang        ; Bucle infinito para que la CPU no se escape

; Relleno sagrado (No tocar)
times 510-($-$$) db 0
dw 0xaa55
