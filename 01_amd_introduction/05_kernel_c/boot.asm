;
; boot.asm - Bootloader que carga el Kernel desde el disco
;

[org 0x7c00]
KERNEL_OFFSET equ 0x1000 ; La misma dirección que pusimos en el linker.ld

    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov fs, ax
    mov gs, ax

    mov [BOOT_DRIVE], dl    ; 0. GUARDAR el número de disco de arranque
    mov bp, 0x9000
    mov sp, bp

    ; 2. Mensaje de bienvenida
    mov bx, MSG_REAL_MODE
    call print_string_16

    ; 3. CARGAR EL KERNEL DEL DISCO
    call load_kernel

    ; 4. Activar línea A20 (Protocolo rápido)
    in al, 0x92
    or al, 2
    out 0x92, al

    ; 5. ¡Salto al modo protegido!
    call switch_to_pm

    jmp $

; --- FUNCIONES ---

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

load_kernel:
    mov bx, MSG_LOAD_KERNEL
    call print_string_16

    mov bx, KERNEL_OFFSET ; Destino: 0x1000
    mov dh, 15            ; Vamos a cargar 15 sectores (por si el kernel crece)
    mov dl, [BOOT_DRIVE]  ; Usamos el disco de arranque que nos da la BIOS
    call disk_load
    ret

disk_load:
    pusha
    push dx

    mov ah, 0x02 ; Función BIOS: Leer sectores
    mov al, dh   ; Número de sectores a leer
    mov cl, 0x02 ; Empezar en el segundo sector (el 1 es el bootloader)
    mov ch, 0x00 ; Cilindro 0
    mov dh, 0x00 ; Cabezal 0

    ; ES:BX es donde Guardamos los datos. ES ya es 0, BX es 0x1000.
    int 0x13      ; INTERRUPCIÓN DE DISCO
    jc disk_error ; Salta si hubo error (Carry Flag)

    pop dx
    cmp al, dh    ; ¿Se leyeron todos los sectores?
    jne disk_error
    popa
    ret

disk_error:
    mov bx, MSG_DISK_ERROR
    call print_string_16
    jmp $

; --- DATOS ---
BOOT_DRIVE      db 0
MSG_REAL_MODE   db "L16: Iniciando en 16-bit...", 0x0D, 0x0A, 0
MSG_LOAD_KERNEL db "L16: Cargando Kernel a 0x1000...", 0x0D, 0x0A, 0
MSG_DISK_ERROR  db "L16: ERROR DE DISCO!", 0

; Incluimos archivos externos
%include "gdt.asm"
%include "switch_pm.asm"

[bits 32]
BEGIN_PM:
    ; Marcador visual: Una 'P' blanca sobre fondo rojo en la esquina superior derecha
    ; Para confirmar que llegamos a 32 bits.
    mov al, 'P'
    mov ah, 0x4f ; Rojo claro
    mov [0xb8000 + 158], ax

    call KERNEL_OFFSET ; ¡SALTAMOS AL KERNEL YA EN 32 BITS!
    jmp $

; Relleno y firma
times 510-($-$$) db 0
dw 0xaa55
