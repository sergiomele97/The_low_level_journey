# Log de Aprendizaje: Mi Primera Compilación Cerebral

*Fecha: 10 de Enero, 2026*

Hoy hemos ensamblado "a mano" nuestra primera instrucción real para RISC-V. Sin GCC, sin Python, solo con el manual de la Capa 0.

## La Misión: Cargar la dirección de la UART
Queremos que el registro `t0` (x5) contenga `0x10000000`. Para ello usamos `LUI` (Load Upper Immediate).

### 1. El Formato (Tipo-U)
La instrucción se divide así:
- **Inmediato (20 bits)**: `0x10000` -> `00010000000000000000`
- **Destino (5 bits)**: `t0` (x5) -> `00101`
- **Opcode (7 bits)**: `LUI` -> `0110111`

### 2. El Puzzle de Bits
Pegamos los trozos:
`00010000000000000000` + `00101` + `0110111` = `00010000000000000000001010110111`

### 3. Conversión a Hex
- Binario: `0001 0000 0000 0000 0000 0010 1011 0111`
- Hexadecimal: `100002B7`

### 4. La Realidad de la Memoria (Little Endian)
Como la CPU lee de derecha a izquierda los bytes (el byte menos significativo primero), en nuestro archivo `.hex` tenemos que escribirlo así:
**`B7 02 00 10`**

## Reflexión:
Es increíble que un número tan pequeño como `0x100002B7` contenga tanta información: la operación, el registro destino y el valor. Esto es lo que realmente ve el silicio.
