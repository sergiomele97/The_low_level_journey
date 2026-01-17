# 15. Números Mayores que 9 (División)
*Fecha: 5 de Enero, 2026*

Para imprimir un número como `15`, la CPU debe imprimir un `'1'` y luego un `'5'`. ¿Cómo separamos los dígitos? **Dividiendo por 10.**

### 1. La instrucción DIV
En x86, la división funciona así para 8 bits:
*   Pones el número en **`AX`**.
*   Llamas a **`DIV registo`**.
*   **AL** = Cociente (Las decenas).
*   **AH** = Resto (Las unidades).

### 2. Ejemplo práctico para el número 15
```assembly
    mov ax, 15      ; El número a imprimir
    mov bl, 10      ; El divisor
    div bl          ; 15 / 10 -> AL=1, AH=5
    
    ; Ahora imprimimos AL ('1') y luego AH ('5')
```

**Nota:** Recuerda limpiar `AH` antes de la división (`mov ah, 0`) para que el valor en `AX` sea el que tú esperas.
