# RISC-V: Herramientas Base (Capa 1)

En esta capa construimos nuestro propio ensamblador: **RASM (RISC-V Micro-Assembler)**. Su misión es traducir mnemónicos legibles por humanos (como `ADD`) a los patrones de bits definidos en la Capa 0.

## 1. El proceso de Ensamblado
RASM funciona de forma secuencial:
1. **Parser**: Lee el archivo `.s` línea por línea, ignorando comentarios y espacios.
2. **Encoders**: Identifica el tipo de instrucción (R, I, S, B, U, J) y aplica la máscara de bits correspondiente.
3. **Binary Writer**: Escribe los 32 bits generados en formato *Little Endian*.

## 2. Codificación por Tipo
Para mantener "Cero Abstracciones", documentamos cómo RASM construye cada tipo de instrucción.

### Tipo-I (Ejemplo: `ADDI rd, rs1, imm`)
Es el que usamos en el bootstrap. Los 32 bits se reparten así:
```
[ imm (12 bits) ][ rs1 (5b) ][ funct3 (3b) ][ rd (5b) ][ opcode (7b) ]
```
- **Opcode**: Indica qeu es una operación inmediata (0x13).
- **Inmediato**: Un número con signo de 12 bits (rango -2048 a 2047).

### Tipo-R (Ejemplo: `ADD rd, rs1, rs2`)
Operaciones entre tres registros. Los 32 bits se reparten así:
```
[ funct7 (7b) ][ rs2 (5b) ][ rs1 (5b) ][ funct3 (3b) ][ rd (5b) ][ opcode (7b) ]
```
- **Opcode**: Indica operación entre registros (0x33).
- **Funct7 + Funct3**: Identifican la operación específica dentro del grupo (ej: ADD es differente de SUB por el bit 30 en funct7).

## 3. Limitaciones de Diseño
Para mantener la simplicidad inicial, RASM tiene estas reglas:
- No soporta etiquetas (labels) complejas todavía (usamos saltos relativos fijos).
- No soporta directivas de ensamblador (como `.data` o `.text`), genera binarios planos directamente.
