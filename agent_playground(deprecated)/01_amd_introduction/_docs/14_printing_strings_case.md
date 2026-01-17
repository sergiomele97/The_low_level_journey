# 14. Caso Práctico: Imprimir una Cadena (Strings)
*Fecha: 5 de Enero, 2026*

Imprimir una letra es fácil. Imprimir una palabra requiere entender cómo la CPU recorre la memoria. Este ejercicio une **Punteros**, **Bucles** y **Subrutinas**.

### 1. Definir los datos en RAM
En ensamblador, una cadena es solo una lista de bytes seguidos en la memoria. Usamos un `0` al final para saber cuándo parar (esto se llama *Null-terminated string*).

```assembly
mi_mensaje: db "Bienvenido al Nucleo", 0
```

### 2. El Algoritmo
No podemos imprimir todo de golpe. Debemos ir letra a letra:
1. Apuntar a la primera letra.
2. Leer la letra.
3. Si es `0`, terminar.
4. Si no, imprimirla.
5. Apuntar a la siguiente y repetir.

### 3. Implementación con Subrutina

```assembly
[org 0x7c00]

start:
    mov bx, mi_mensaje   ; BX guarda la dirección de la primera letra
    call imprimir_string ; Llamamos a nuestra función
    
    jmp $                ; Bloqueamos la CPU

; --- SUBRUTINA ---
imprimir_string:
    push ax              ; Protegemos AX
    push bx              ; Protegemos BX
    
bucle_string:
    mov al, [bx]         ; AL = Contenido de la dirección en BX
    cmp al, 0            ; ¿Es el fin?
    je fin_string        ; Si es cero, saltamos fuera
    
    mov ah, 0x0e         ; BIOS teletype
    int 0x10             ; Imprimir caracter en AL
    
    inc bx               ; BX = BX + 1 (Siguiente dirección)
    jmp bucle_string     ; ¡Bucle!

fin_string:
    pop bx               ; Recuperamos registros
    pop ax
    ret

mi_mensaje: db "Hola desde el metal!", 0

times 510-($-$$) db 0
dw 0xaa55
```

### ¿Por qué `INC BX` y no `INC BL`?
*   `BL` es solo un byte (hasta 255).
*   `BX` es la dirección de 16-bits (hasta 65535).
Como las direcciones de memoria son grandes, debemos incrementar el registro completo (`BX`) para movernos por el mapa de la RAM.
