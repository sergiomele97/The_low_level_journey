# Log 09: El Puzzle del Echo (Saltos y Polling)

*Fecha: 10 de Enero, 2026*

Para que el procesador "escuche", necesitamos un bucle que no le deje escapar hasta que haya una tecla pulsada. Esto se llama **Polling**.

## El Programa Echo (Paso a Paso)

Este es el esquema que vamos a inyectar. Es la primera vez que usamos saltos condicionales (**BEQ**):

| Dirección | Instrucción | Hex (Little Endian) | Explicación |
| :--- | :--- | :--- | :--- |
| 0x00 | `lui t0, 0x10000` | `B7 02 00 10` | t0 = Base UART (0x10000000) |
| 0x04 | `lbu t1, 5(t0)` | `03 C3 52 00` | Leer LSR (Estado) en t1 |
| 0x08 | `andi t1, t1, 1` | `13 73 13 00` | Aislar bit 0 (Data Ready) |
| 0x0C | `beq t1, x0, -8` | `E3 0C 03 FE` | Si es 0, volver a dirección 0x04 |
| 0x10 | `lbu t1, 0(t0)` | `03 C3 02 00` | Leer dato real de la UART |
| 0x14 | `sb t1, 0(t0)` | `23 80 62 00` | Escribir ese mismo dato (Echo) |
| 0x18 | `jal x0, -20` | `6F F0 6F FF` | Volver al inicio del bucle (0x04) |

### ¿Por qué saltamos -8 y -20?
- En el `BEQ` (0x0C), saltar `-8` nos devuelve a 0x04 (0x0C - 8 = 0x04).
- En el `JAL` (0x18), saltar `-20` nos devuelve también a 0x04 (0x18 - 20 = 0x04).

Es aritmética pura aplicada a las direcciones de memoria.

> [!TIP]
> **Little Endian**: Fíjate que el `E3` o el `6F` (los opcodes de salto) aparecen al principio del bloque de 4 bytes. Eso es porque son los bits más bajos de la instrucción y RISC-V los guarda primero.
