.section .text
.globl _start

_start:
    li t0, 0x10000000      # Dirección de la UART

bucle_eco:
    # 1. Leer de la UART (Entrada)
    # En la máquina virt, leer de 0x10000000 te da el carácter pulsado
    lbu t1, 0(t0)          
    
    # 2. Comprobar si hay dato
    # (A veces la UART devuelve 0 o -1 si no hay nada, 
    # pero QEMU en este modo suele esperar a que pulses)
    
    # 3. Escribir en la UART (Salida)
    sb t1, 0(t0)           
    
    j bucle_eco            # Volver a empezar