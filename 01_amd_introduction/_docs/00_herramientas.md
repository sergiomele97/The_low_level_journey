# 00. El Inicio: Herramientas del Oficio
*Fecha: 4 de Enero, 2026*

Para comenzar a construir un Sistema Operativo desde cero, necesitamos bajar al metal. No nos sirven los compiladores complejos ni los entornos visuales por ahora. Necesitamos control total sobre cada byte.

### Aprendizajes

#### 1. NASM (Netwide Assembler)
¿Por qué no usar el ensamblador de GCC (`as`)? Porque NASM es más "honesto".
*   **Lo que hace:** Traduce nuestras instrucciones en ensamblador (mnemónicos como `MOV`, `JMP`) directamente a código máquina (binario puro).
*   **La ventaja:** Nos permite generar archivos "flat binary" (binarios planos) sin cabeceras extrañas que Linux o Windows necesitan para ejecutar programas (.exe, .elf). Un SO en su arranque es solo un chorro de bytes en el disco, y NASM nos deja crear exactamente eso.

#### 2. QEMU (Quick Emulator)
Probar un SO en hardware real es lento (copiar a USB, reiniciar, rezar).
*   **Lo que hace:** Emula un PC completo por software (CPU, RAM, Disco, Pantalla).
*   **La ventaja:** Nos permite ejecutar nuestro archivo binario como si fuera un disco duro de arranque. Es nuestro laboratorio de pruebas seguro. Si el código falla y "cuelga" la CPU, solo cerramos la ventana.

#### 3. Ensamblador, Mnemónicos y la Máquina
Es crucial entender la jerarquía:
*   **Código Máquina:** `B8 04 00` (Lo que la CPU come. Voltajes).
*   **Ensamblador (Lenguaje):** `MOV AX, 4` (Mnemónicos legibles por humananos).
*   **Ensamblador (Programa):** `NASM`. El traductor que convierte `MOV AX, 4` -> `B8 04 00`.

#### 4. Binario vs Hexadecimal
Son lo mismo, solo cambia la representación. El Hexadecimal es una compresión visual del binario, usada porque leer `10111000` duele.
*   `1011` (Bin) = `B` (Hex)
*   `1000` (Bin) = `8` (Hex)
*   `10111000` = `0xB8`

#### 5. x86 (La Arquitectura)
Es el "idioma nativo" de nuestro procesador (Intel/AMD).
*   Un chip **ARM** (Móvil) no entiende x86.
*   Nosotros escribiremos instrucciones para x86 (`MOV`, `JMP`) porque estamos desarrollando para PC.
