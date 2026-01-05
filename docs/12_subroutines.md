# 12. Subrutinas y La Pila (The Stack)
*Fecha: 5 de Enero, 2026*

A medida que nuestros programas crecen, repetir código se vuelve insostenible. Necesitamos "funciones". En ensamblador se llaman **Subrutinas**.

### 1. CALL y RET
*   **`CALL etiqueta`**: Salta a la etiqueta, pero recuerda de dónde viene.
*   **`RET`**: Salta de vuelta a la instrucción justo después del `CALL`.

**Ejemplo:**
```assembly
    mov al, 'X'
    call print_char  ; Salta
    ; ... la CPU vuelve aquí ...

print_char:
    mov ah, 0x0e
    int 0x10
    ret              ; Vuelve
```

### 2. La Pila (The Stack)
La CPU usa una zona de memoria llamada **Stack** para recordar las direcciones de retorno. Funciona como una pila de platos (LIFO: Last In, First Out).

#### PUSH y POP
Si vas a usar un registro dentro de una subrutina y no quieres "ensuciar" el valor que tenía fuera, usa la pila:

```assembly
mi_subrutina:
    push ax         ; Guarda el AX original en la pila
    mov ax, 5       ; Úsalo para lo que quieras
    pop ax          ; Recupera el AX original antes de volver
    ret
```

### 3. El registro SP (Stack Pointer)
El registro **SP** apunta a la dirección de memoria donde está el plato superior de la pila. Cada vez que haces `PUSH`, `SP` baja (la pila crece hacia abajo en memoria en x86).

**¡CUIDADO!** Si haces un `PUSH` pero te olvidas del `POP` antes del `RET`, la CPU leerá tu dato guardado como si fuera la dirección de retorno y saltará a una parte aleatoria del código. **¡CRASH SEGURO!**
