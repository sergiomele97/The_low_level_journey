[org 0x7c00]

    ; 1. Inicializar segmentos a cero
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    ; 2. Establecer la pila
    mov bp, 0x9000
    mov sp, bp

    ; 3. Activar línea A20 (Protocolo rápido)
    in al, 0x92
    or al, 2
    out 0x92, al

    mov bx, MSG_REAL_MODE
    call print_string_16

    call switch_to_pm ; ¡Salto al vacío!

    jmp $

; --- FUNCIONES 16 BITS ---
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

; Incluimos piezas externas
%include "gdt.asm"
%include "switch_pm.asm"

[bits 32]
; --- CÓDIGO 32 BITS ---
BEGIN_PM:
    mov ebx, MSG_PROT_MODE
    call print_string_pm 

    jmp $

print_string_pm:
    pusha
    mov edx, 0xb8000 
.loop:
    mov al, [ebx]
    mov ah, 0x0f    ; Blanco sobre negro
    cmp al, 0
    je .done
    mov [edx], ax   ; Pintar en VGA
    add ebx, 1
    add edx, 2
    jmp .loop
.done:
    popa
    ret

; --- DATOS ---
MSG_REAL_MODE db "L16: Modo Real activo. Saltando...", 0x0D, 0x0A, 0
MSG_PROT_MODE db "L32: MODO PROTEGIDO ACTIVADO (Sin BIOS)", 0

; Relleno y firma
times 510-($-$$) db 0
dw 0xaa55
