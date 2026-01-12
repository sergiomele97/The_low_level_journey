# --- MACROS DE ABSTRACCIÓN ---

.macro ESPERAR_UART_LISTA
    li t0, 0x10000000          # t0 = Dirección Base UART
100:                           
    lbu t1, 5(t0)              # t1 = Lee LSR (Line Status Register)
    andi t1, t1, 0x20          # Máscara: bit 5 (Transmisor vacío)
    beqz t1, 100b              # Si 0 (ocupado), reintentar
.endm

.macro ENVIAR_CARACTER reg
    ESPERAR_UART_LISTA         # Espera hardware listo
    li t0, 0x10000000          # t0 = Dirección Base UART
    sb \reg, 0(t0)             # Store Byte: Escribe carácter en UART
.endm

.macro IMPRIMIR_STRING etiqueta
    la s1, \etiqueta           # s1 = Puntero al inicio del string
200:                           
    lbu s2, 0(s1)              # s2 = Carga byte actual desde memoria
    beqz s2, 300f              # Si s2 == 0 (fin .asciz), salir
    ENVIAR_CARACTER s2         # Llama envío de carácter
    addi s1, s1, 1             # Incrementa puntero (1 byte)
    j 200b                     # Bucle siguiente carácter
300:
.endm

# --- PROGRAMA PRINCIPAL ---

.section .text                 # Sección de código ejecutable
.globl _start                  # Punto de entrada para Linker
.align 2                       # Alineación a 4 bytes (instrucción)

_start:
    IMPRIMIR_STRING mi_texto   # Expande macro de impresión

loop_final:
    j loop_final               # Bucle infinito de parada

# --- SECCIÓN DE DATOS ---

.section .data                 # Sección de variables/datos
.align 2                       # Alineación de memoria de datos
mi_texto:
    .asciz "Hola desde RISC-V!\n" # String con terminador nulo (0x00)