;
; A simple boot sector that prints a message to the screen using BIOS interrupts.
;

[org 0x7c00]          ; Tell NASM that BIOS loads us at memory address 0x7c00
                      ; This is crucial for label addresses to be correct.

mov ah, 0x0e          ; INT 10h / AH = 0x0e -> BIOS teletype output function
mov bx, variable_msg  ; Load the address of our message string into BX

print_loop:
    mov al, [bx]      ; Move the character at address [BX] into AL
    cmp al, 0         ; Compare AL with 0 (null terminator)
    je hang           ; If it is 0 (end of string), jump to 'hang' label
    int 0x10          ; Call BIOS interrupt 0x10 (Video Services) to print char in AL
    inc bx            ; Increment BX to point to the next character
    jmp print_loop    ; Jump back to the start of the loop

hang:
    jmp $             ; Infinite loop (jump to current address $) to stop execution.
                      ; Otherwise CPU would execute garbage memory after our code.

variable_msg:
    db "Hello Low Level World!", 0   ; Define Byte (db) string, null terminated

; Padding and Magic Number
times 510-($-$$) db 0   ; Fill the rest of the 512 bytes with 0s
dw 0xaa55               ; The Magic Number (2 bytes) marking this as bootable
