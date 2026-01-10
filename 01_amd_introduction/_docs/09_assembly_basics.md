# 09. Assembly 101: El Gimnasio de la CPU
*Fecha: 5 de Enero, 2026*

Para que puedas "trastear", necesitas conocer las herramientas básicas. Olvida las funciones complejas, aquí solo hay cajas y movimientos.

### 1. Las Cajas (Registros)
La CPU tiene memoria ultrarrápida (Registros). En modo 16-bits, son de 2 bytes (16 unos/ceros).
Imagina que tienes **4 manos**:
*   **AX (Acomulator):** La mano principal. Se usa para operaciones matemáticas.
*   **BX (Base):** Se usa para guardar direcciones de memoria (punteros).
*   **CX (Counter):** Se usa para bucles (como la `i` en un `for`).
*   **DX (Data):** Auxiliar para datos.

Cada mano se puede dividir en dos dedos (High y Low):
*   `AX` (16 bits) = `AH` (8 bits, parte alta) + `AL` (8 bits, parte baja).

### 2. Los Movimientos (Instrucciones Básicas)
Todo programa se hace combinando estas 4 piezas de Lego:

#### A. Mover cosas (MOV)
```assembly
mov ax, 10    ; Mete el número 10 en la caja AX
mov bx, ax    ; Copia lo que hay en AX a BX (Ahora BX vale 10)
```

#### B. Matemáticas (ADD, SUB, INC, DEC)
```assembly
add ax, 5     ; Suma 5 a AX (AX = AX + 5)
sub ax, 2     ; Resta 2 a AX
inc ax        ; Incrementa AX en 1 (AX++)
dec ax        ; Decrementa AX en 1 (AX--)
```

#### C. Comparar (CMP)
La CPU tiene una "bandera" invisible que se levanta si una resta da cero.
```assembly
cmp ax, 5     ; Compara AX con 5. (Internamente hace una resta imaginaria).
              ; Si son iguales, levanta la bandera "Zero Flag" (ZF).
```

#### D. Saltar (JMP, JE, JNE)
Aquí es donde ocurre la lógica (`if/else`).
```assembly
jmp etiqueta  ; Salta incondicionalmente a "etiqueta" (GOTO).
je etiqueta   ; Jump if Equal. Salta solo si el CMP anterior dijo que eran iguales.
jne etiqueta  ; Jump if Not Equal. Salta si eran distintos.
```

### Ejemplo: If (AX == 5) { BX = 1 }
```assembly
    cmp ax, 5       ; ¿Es AX igual a 5?
    jne no_es_cinco ; Si NO es igual, sáltate la siguiente instrucción.
    mov bx, 1       ; (Solo se ejecuta si AX era 5)
    jmp fin         ; Saltamos al final para no ejecutar el 'else'

no_es_cinco:
    mov bx, 0       ; El 'else'

fin:
    ; Continuar...
```
