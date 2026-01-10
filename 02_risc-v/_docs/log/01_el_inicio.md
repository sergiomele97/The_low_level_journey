# Diario de Aprendizaje: RISC-V de Cero a Infinito

*Fecha: 10 de Enero, 2026*

## El Gran Viraje: De x86 a RISC-V Pura
Hoy hemos tomado una decisión radical. Veníamos de estudiar x86 con herramientas estándar (`gcc`, `nasm`), pero Sergio ha decidido que queremos **Pureza Absoluta**. 

### ¿Qué significa esto?
Significa que no nos vale con hacer un SO; queremos ser dueños de CADA BIT del proceso. Si usamos Python para el ensamblador, el sistema "nace" de un código que no es nuestro. Así que hemos borrado `rasm.py` y hemos decidido que nuestro primer ensamblador será un binario inyectado a mano.

### Dudas Resueltas hoy:
1. **¿Es GCC trampa?**: Concluimos que sí. Si el objetivo es "Zero Abstractions", delegar la generación de código a una herramienta externa tan compleja rompe la magia.
2. **¿Por qué 32 bits?**: RV32I es el set mínimo. Es más fácil de depurar en hexadecimal (direcciones cortas) y todo lo aprendido es escalable a 64 bits.

### El reto de la UART:
Para poder hacer un ensamblador interactivo, necesito que la CPU hable con Sergio. Hemos descubierto (vía manual de QEMU) que la **UART** vive en `0x10000000`. 

**La gran duda que surge:** ¿Cómo enviamos una cadena de texto sin `printf`? 
**Respuesta:** Tendremos que hacer un bucle en ensamblador que recorra los bytes de la cadena y los meta uno a uno en esa dirección de memoria. Pero antes de eso... ¡Habrá que codificar ese bucle a mano en Hexadecimal!

*Próxima parada: "Hello World" vía inyección de Hex.*
