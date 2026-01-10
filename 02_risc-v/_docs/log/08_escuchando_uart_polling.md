# Log 08: Escuchando al Mundo (UART Polling)

*Fecha: 10 de Enero, 2026*

Ya sabemos gritar ('A'), pero ¿cómo escuchamos? Para que nuestro ensamblador funcione, Sergio tiene que poder escribir comandos.

## El Problema del Tiempo
La CPU corre a millones de ciclos por segundo. Sergio pulsa una tecla de vez en cuando. Si la CPU intenta leer la UART en un momento en que no hay nada, leerá basura o simplemente el último carácter repetido.

## La Solución: Polling (Muestreo)
En la Capa 1 vimos un registro llamado **LSR** (Line Status Register) en la dirección `0x10000005`. 
El **Bit 0** de ese registro nos dice la verdad:
- **0**: No hay nada nuevo.
- **1**: ¡Hay un dato! Alguien ha pulsado una tecla.

### El Algoritmo de Escucha:
1. **Mirar** el buzón de estado (`0x10000005`).
2. **¿Es el bit 0 un uno?**
   - **NO**: Vuelve al paso 1 (un bucle infinito de espera).
   - **SÍ**: Lee el carácter del registro de datos (`0x10000000`).

## ¿Cómo se traduce esto a RISC-V?
Necesitamos una instrucción que cargue el contenido de la memoria (**LW** o **LB**) y una que compare (**BEQ** o **BNE**).

### El Reto del Echo:
Un programa de "Echo" es el que lee una tecla y la imprime inmediatamente detrás. Es el test definitivo de que la comunicación es bidireccional.

**Plan de bits para el Echo**:
1. Cargar dirección Base UART (`0x10000000`) en `t0`.
2. Bucle de espera (Polling):
   - Leer LSR (`0x10000005`) en `t1`.
   - Si `t1` AND `1` es `0`, saltar al inicio del bucle.
3. Leer Dato:
   - Leer Byte de `0x10000000` en `t2`.
4. Escribir Dato (Echo):
   - Escribir `t2` en `0x10000000`.
5. Volver al paso 2.

Este será nuestro último experimento antes de empezar el ensamblador nativo.
