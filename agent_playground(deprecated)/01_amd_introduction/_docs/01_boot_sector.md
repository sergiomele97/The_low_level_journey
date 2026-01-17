# 01. El Primer Aliento: Boot Sector
*Fecha: 4 de Enero, 2026*

Hemos escrito nuestro primer programa "Bare Metal". Sin sistema operativo debajo que nos ayude. Somos nosotros, la CPU y la BIOS.

### El Código (`boot.asm`)
Nuestro programa hace lo siguiente:
1.  **`[org 0x7c00]`**: Le decimos a NASM que la BIOS nos cargará en la dirección de memoria `0x7C00`. Si no ponemos esto, nuestros punteros a variables estarían mal calculados.
2.  **`MOV AH, 0x0E`**: Preparamos el registro AH para decirle a la BIOS "Quiero imprimir un carácter en modo teletipo".
3.  **El Bucle**:
    *   Leemos un carácter de nuestro mensaje.
    *   Comprobamos si es 0 (el final, como en C).
    *   Si no es 0, ejecutamos `INT 0x10` (¡La llamada a la BIOS!).
    *   Repetimos.
4.  **`JMP $`**: Un bucle infinito al final. Si la CPU siguiera ejecutando instrucciones más allá de nuestro código, se encontraría con memoria basura y probablemente se reiniciaría o haría cosas raras. Aquí la "congelamos".
5.  **La Magia (`0xAA55`)**: Rellenamos con ceros hasta el byte 510 y ponemos `AA 55` al final. Sin esto, la BIOS diría "No bootable device found".

### Compilación y Ejecución
```bash
nasm -f bin boot.asm -o boot.bin
qemu-system-x86_64 boot.bin
```
El resultado: Una ventana negra con "Hello Low Level World!".
Estado: **ÉXITO**.

---
**Siguiente Paso:** Entender cómo pasar de este modo limitado (16-bit Real Mode) al modo protegido (32-bit Protected Mode) para poder usar más de 1MB de RAM y acceder a la potencia real de la CPU.
