# Capa 0: El Manual ISA (RV32I)

Esta es la "Ley del Silicio". No hay nada por debajo de esto. Partimos de un procesador que solo entiende estos patrones de bits de 32 bits.

## 1. Formatos de Instrucción
Para que la CPU sea simple, RISC-V solo tiene unos pocos formatos de 32 bits. La posición de los registros es siempre la misma:

- **R-Type**: Op: `0110011` | [funct7][rs2][rs1][funct3][rd][opcode]
- **I-Type**: Op: `0010011` | [imm[11:0]][rs1][funct3][rd][opcode]
- **S-Type**: Op: `0100011` | [imm[11:5]][rs2][rs1][funct3][imm[4:0]][opcode]
- **B-Type**: Op: `1100011` | [imm[12]][imm[10:5]][rs2][rs1][funct3][imm[4:1]][imm[11]][opcode]
- **U-Type**: Op: `0110111` | [imm[31:12]][rd][opcode]
- **J-Type**: Op: `1101111` | [imm[20]][imm[10:1]][imm[11]][imm[19:12]][rd][opcode]

## 2. Mapa de Opcodes e Inscripciones (RV32I)

| Mnemónico | Tipo | Opcode | Funct3 | Funct7 | Descripción |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **LUI** | U | 0110111 | - | - | rd = imm << 12 |
| **AUIPC** | U | 0010111 | - | - | rd = pc + (imm << 12) |
| **JAL** | J | 1101111 | - | - | rd = pc+4; pc += imm |
| **BEQ** | B | 1100011 | 000 | - | if(rs1==rs2) pc += imm |
| **ADDI** | I | 0010011 | 000 | - | rd = rs1 + imm |
| **LW** | I | 0000011 | 010 | - | rd = M[rs1 + imm] |
| **SW** | S | 0100011 | 010 | - | M[rs1 + imm] = rs2 |
| **ADD** | R | 0110011 | 000 | 0000000 | rd = rs1 + rs2 |
| **SUB** | R | 0110011 | 000 | 0100000 | rd = rs1 - rs2 |

## 3. Registros (El Estado del Mundo)
Disponemos de 32 registros de 32 bits. El registro **x0** es especial: cualquier intento de lectura devuelve 0, y cualquier escritura se ignora.

| Registro | Alias | Rol (ABI) |
| :--- | :--- | :--- |
| **x0** | `zero` | Cero constante |
| **x1** | `ra` | Dirección de retorno |
| **x2** | `sp` | Puntero de pila |
| **x5-x7** | `t0-t2` | Temporales |
| **x10-x11** | `a0-a1` | Argumentos / Retorno |

---
> [!NOTE]
> **Alineamiento**: Todas las instrucciones miden 32 bits y deben estar alineadas a direcciones de 4 bytes.

> [!TIP]
> **Autenticidad**: Este manual es un resumen fiel de la especificación *The RISC-V Instruction Set Manual, Volume I: Unprivileged ISA*.
