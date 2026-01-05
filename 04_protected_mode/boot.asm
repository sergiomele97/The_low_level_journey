;
; boot.asm - Punto de entrada para el salto a 32 bits
;

[org 0x7c00]

    mov bp, 0x9000  ; Establecer la pila de 16 bits
    mov sp, bp

    mov bx, MSG_REAL_MODE
    call print_string_16

    call switch_to_pm ; ¡Aquí es donde ocurre la magia!

    jmp $ ; Por seguridad

; Incluimos nuestras piezas
%include "gdt.asm"
%include "switch_pm.asm"

[bits 32]
; Este es el código que se ejecutará en 32 BITS
BEGIN_PM:
    mov ebx, MSG_PROT_MODE
    call print_string_pm ; Nuestra propia función de impresión 32-bits (sin BIOS)

    jmp $

; Una función simple de impresión para 32 bits que escribe directo en 0xb8000
print_string_pm:
    pusha
    mov edx, 0xb8000 ; Dirección de inicio de la memoria VGA

.loop:
    mov al, [ebx]    ; Obtener el caracter
    mov ah, 0x0f    ; Atributos (Blanco sobre negro)

    cmp al, 0        ; ¿Fin de la cadena?
    je .done

    mov [edx], ax    ; ESCRIBIMOS DIRECTO EN EL HARDWARE (VGA RAM)
    add ebx, 1       ; Siguiente caracter
    add edx, 2       ; Siguiente casilla de memoria (cada letra son 2 bytes: char + attr)

    jmp .loop

.done:
    popa
    ret

; --- DATOS ---
MSG_REAL_MODE db "Iniciado en 16-bit Real Mode", 0
MSG_PROT_MODE db "CONSEGUIDO: Funcionando en 32-bit Protected Mode!", 0

; Para que compile necesitamos la función antigua de 16 bits para el mensaje de inicio
; La defino aquí mismo para no depender de archivos externos por ahora
print_string_16:
    pusha
    mov ah, 0x0e
.loop:
    mov al, [bx]
    cmp al, 0
    je .done
    int 0x10
    add bx, 1
    jmp .loop
.done:
    popa
    ret

; Relleno y magia
times 510-($-$$) db 0
dw 0xaa55
