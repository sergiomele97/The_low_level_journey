# x86 16-bit Quick Reference

## 1. Registros (16 bits / 8 bits)
*   **AX** (AH/AL): Acumulator (Mates/BIOS)
*   **BX** (BH/BL): Base (Punteros `[]`)
*   **CX** (CH/CL): Counter (Bucles)
*   **DX** (DH/DL): Data (Auxiliar)

## 2. Instrucciones Cruciales
*   `MOV dest, orig` : Copiar datos.
*   `CMP a, b`      : Comparar (levanta banderas).
*   `ADD/SUB a, b`  : Sumar / Restar.
*   `INC/DEC a`     : a++ / a--
*   `INT 0x??`      : Llamar a BIOS.

## 3. Saltos (Control de flujo)
*   `JMP label` : Saltar siempre.
*   `JE`  : Si igual (==)
*   `JNE` : Si distinto (!=)
*   `JL`  : Si menor (<)
*   `JG`  : Si mayor (>)

## 4. Subrutinas y Pila
*   `CALL label` : Ir a función.
*   `RET`        : Volver de función.
*   `PUSH reg`   : Guardar en pila.
*   `POP reg`    : Recuperar de pila.

## 5. Memoria
*   `[bx]` : El contenido de la dirección en BX.
*   `db 'a', 0` : Definir datos (strings).
