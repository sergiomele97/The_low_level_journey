# RISC-V: La Interfaz de la CPU (Capa 0)

Este documento define el nivel más bajo del sistema: el "contrato" con el silicio. Partimos de una arquitectura **RV32I** (RISC-V 32-bit Integer).

## 1. El Banco de Registros
Disponemos de **32 registros** de propósito general. Todos son de **32 bits**.

| Registro | Alias ABI | Descripción | Regla del juego |
| :--- | :--- | :--- | :--- |
| **x0** | `zero` | Cero constante | Siempre vale 0. Escribir aquí no hace nada. |
| **x1** | `ra` | Return Address | Dirección de retorno para funciones. |
| **x2** | `sp` | Stack Pointer | Puntero de la pila. |
| **x3** | `gp` | Global Pointer | Puntero a datos globales. |
| **x4** | `tp` | Thread Pointer | Hilos local storage. |
| **x5-x7** | `t0-t2` | Temporals | Registros para cálculos rápidos. |
| **x8** | `s0`/`fp` | Saved/Frame | Frame pointer o registro guardado. |
| **x9** | `s1` | Saved | Registro guardado. |
| **x10-x11** | `a0-a1` | Args/Return | Argumentos de función o valor de retorno. |
| **x12-x17** | `a2-a7` | Arguments | Más argumentos para funciones. |
| **x18-x27** | `s2-s11` | Saved | Registros guardados. |
| **x28-x31** | `t3-t6` | Temporals | Más registros temporales. |
| **pc** | - | Program Counter | La dirección de la instrucción actual (no accesible directamente como xN). |

## 2. Los 6 Formatos de Instrucción
Para simplificar el hardware, RISC-V usa solo 6 formatos fijos de 32 bits.

- **Tipo-R (Register)**: Operaciones entre registros (ADD, SUB, AND, OR).
- **Tipo-I (Immediate)**: Operaciones con números inmediatos o Cargas (ADDI, LW).
- **Tipo-S (Store)**: Guardar en memoria (SW, SB).
- **Tipo-B (Branch)**: Saltos condicionales (BEQ, BNE).
- **Tipo-U (Upper)**: Cargar inmediatos grandes (LUI).
- **Tipo-J (Jump)**: Saltos incondicionales (JAL).

> [!TIP]
> **Little Endian**: Al igual que x86, RISC-V lee los bytes "al revés" en memoria. El byte menos significativo va primero.

## 3. El Set Base (RV32I)
Este set mínimo de ~47 instrucciones es suficiente para ejecutar un sistema operativo completo. No necesitamos extensiones de coma flotante ni multiplicaciones complejas para empezar.

**Control de flujo:**
- `JAL`, `JALR`: Saltos y enlace.
- `BEQ`, `BNE`, `BLT`, `BGE`: Saltos condicionales.

**Aritmética/Lógica:**
- `ADDI`, `SLTI`, `ANDI`, `ORI`, `XORI`: Operaciones con inmediatos.
- `ADD`, `SUB`, `SLL`, `SLT`, `AND`, `OR`, `XOR`: Operaciones entre registros.

**Memoria:**
- `LW`, `LH`, `LB`: Cargar de memoria.
- `SW`, `SH`, `SB`: Guardar en memoria.
