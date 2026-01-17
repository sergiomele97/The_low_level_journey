.section .text
.globl _start

_start:
    li t0, 0x10000000      # Dirección UART

bucle_eco:

esperar_dato:
    lbu t1, 5(t0)          # Leemos el registro LSR (base + 5)
    andi t1, t1, 1         # Máscara: nos quedamos solo con el Bit 0
    beqz t1, esperar_dato  # Si es 0, vuelve a preguntar (no hay nada)

    # --- 2. LEER EL DATO ---
    lbu t2, 0(t0)          # Ahora sí, leemos la letra real

    # --- 3. ESPERAR A QUE LA UART PUEDA TRANSMITIR ---
    # El Bit 5 del LSR nos dice si el transmisor está vacío
esperar_transmisor:
    lbu t1, 5(t0)
    andi t1, t1, 0x20      # 0x20 es el Bit 5 (32 en decimal)
    beqz t1, esperar_transmisor # Si es 0, la UART está ocupada enviando

    # --- 4. ESCRIBIR EL DATO ---
    sb t2, 0(t0)           
    
    j bucle_eco            # Volver a empezar