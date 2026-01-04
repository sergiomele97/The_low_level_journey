;
; A simple boot sector that echoes keyboard input to the screen.
; Interrupts used:
;   INT 0x16, AH=0x00 -> Read key press (blocking)
;   INT 0x10, AH=0x0E -> Teletype output
;

[org 0x7c00]

mov ah, 0x0e
mov al, '>'       ; Prompt character
int 0x10
mov al, ' '
int 0x10

typewriter_loop:
    ; 1. Wait for key press
    mov ah, 0x00
    int 0x16      ; AL will contain the ASCII character

    ; 2. Print the character back
    mov ah, 0x0e
    int 0x10

    ; 3. Repeat
    jmp typewriter_loop

; Store zero padding and magic number
times 510-($-$$) db 0
dw 0xaa55
