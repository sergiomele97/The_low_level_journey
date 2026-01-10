# Log de Aprendizaje: El Puzzle del Tipo-I y Tipo-S

*Fecha: 10 de Enero, 2026*

Tras cargar la dirección de la UART, necesitamos cargar la letra y enviarla. Aquí es donde los "formularios" (formatos) se ponen interesantes.

## 1. Cargando la letra 'A' (ADDI t1, zero, 65)
Usamos el **Tipo-I** (Inmediato).

- **Inmediato (12 bits)**: 65 -> `000001000001`
- **Registro Origen (rs1)**: `zero` (x0) -> `00000`
- **Funct3**: `000`
- **Registro Destino (rd)**: `t1` (x6) -> `00110`
- **Opcode**: `0010011` (19)

**Resultado Binario:** `00000100000100000000001100010011`
**Hexadecimal:** `0x04100313`
**Little Endian:** `13 03 10 04`

## 2. Enviando a la UART (SB t1, 0(t0))
Aquí usamos el **Tipo-S** (Store). Es el formato más "raro" porque el número (el offset 0) se parte en dos.

- **Inmediato Parte 1 (7 bits)**: 0 -> `0000000`
- **Registro rs2 (el dato)**: `t1` (x6) -> `00110`
- **Registro rs1 (la dirección)**: `t0` (x5) -> `00101`
- **Funct3**: `000` (SB - Store Byte)
- **Inmediato Parte 2 (5 bits)**: 0 -> `00000`
- **Opcode**: `0100011` (35)

**Resultado Binario:** `00000000011000101000000000100011`
**Hexadecimal:** `0x00628023`
**Little Endian:** `23 80 62 00`

## Conclusión:
Ya tenemos la receta completa para hablar con el hardware:
1. `B7 02 00 10` (Apunta a UART)
2. `13 03 10 04` (Prepara la 'A')
3. `23 80 62 00` (Escribe en UART)
4. `6F 00 00 00` (Bucle infinito)
