;
; switch_pm.asm - El "ritual sagrado" del cambio a 32 bits
;

[bits 16]
switch_to_pm:
    cli                     ; 1. Desactivar interrupciones (BIOS ya no nos sirve)
    lgdt [gdt_descriptor]  ; 2. Cargar la Global Descriptor Table

    mov eax, cr0            ; 3. Encender el bit 1 (PE - Protection Enable) de CR0
    or eax, 0x1
    mov cr0, eax

    ; 4. Far Jump (Salto largo)
    ; Forzamos a la CPU a vaciar su cola de ejecución de 16 bits
    ; CODE_SEG apunta a nuestro descriptor de código en la GDT
    jmp CODE_SEG:init_pm

[bits 32]
init_pm:
    ; 5. Actualizar los registros de segmento con el descriptor de DATOS
    mov ax, DATA_SEG
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    ; 6. Actualizar la pila (Stack) ahora que tenemos 32 bits de espacio
    mov ebp, 0x90000
    mov esp, ebp

    call BEGIN_PM   ; Saltamos al código final de 32 bits
