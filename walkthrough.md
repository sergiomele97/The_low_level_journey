# Walkthrough: La Odisea de los 16 Bits

Hemos completado la fase de entrenamiento básico en el "Gimnasio de Ensamblador". Sergio ha pasado de cambiar una letra en un binario a construir una calculadora interactiva que maneja memoria y lógica condicional.

## Hitos Alcanzados

### 1. Dominio de Registros y Memoria
- **Registros:** Aprendimos a usar `AX`, `BX`, `CX` y `DX` como nuestras manos principales, y cómo se dividen en partes altas y bajas (`AH`, `AL`).
- **Acceso a RAM:** Implementamos el uso de corchetes `[]` para leer y escribir en direcciones físicas reales.
- **Punteros:** Usamos `BX` como guía para recorrer cadenas de texto en la memoria.

### 2. Flujo de Control y Lógica
- **Saltos:** Implementamos `if/else` usando `CMP` y saltos condicionales (`JE`, `JNE`, `JL`, `JG`).
- **Bucles:** Creamos contadores y filtros de entrada para convertir minúsculas a mayúsculas en tiempo real.
- **Detección de Salida:** Implementamos una "tecla de escape" ('q') para romper bucles infinitos.

### 3. Modularización (Librerías)
- Creamos [`bios_io.asm`](file:///home/sergio/work/antigravity/The_low_level_journey/03_assembly_playground/bios_io.asm) para encapsular las llamadas a la BIOS.
- Aprendimos a usar `%include` para mantener el código limpio y profesional.

### 4. Casos Prácticos Documentados
- [11. Suma Interactiva](file:///home/sergio/work/antigravity/The_low_level_journey/docs/11_interactive_sum_case.md): Conversión ASCII y manejo de registros.
- [14. Imprimir Strings](file:///home/sergio/work/antigravity/The_low_level_journey/docs/14_printing_strings_case.md): Algoritmo de recorrido de memoria.
- [15. Números > 9](file:///home/sergio/work/antigravity/The_low_level_journey/docs/15_multi_digit_output.md): Uso de la instrucción `DIV` para separar decenas y unidades.

## Estado Actual del Repositorio
El proyecto está ahora organizado en:
- `01_boot_sector/`: Nuestro primer aliento.
- `02_keyboard_driver/`: El primer contacto con el hardware.
- `03_assembly_playground/`: El laboratorio de experimentos.
- `docs/`: 15 capítulos de teoría y práctica pura.

---
**Siguiente Parada:** Romper la barrera de los 16-bits. Investigar el **GDT** (Global Descriptor Table) y saltar al **Modo Protegido (32-bit)**.

## Fase 3: El Gran Salto (32 bits)

### 1. El Switch a Protected Mode
Hemos implementado el "ritual sagrado" para pasar de 16 a 32 bits:
- **GDT ([gdt.asm](file:///home/sergio/work/antigravity/The_low_level_journey/04_protected_mode/gdt.asm))**: Definimos los descriptores de segmento para código y datos.
- **Switch ([switch_pm.asm](file:///home/sergio/work/antigravity/The_low_level_journey/04_protected_mode/switch_pm.asm))**: Desactivamos interrupciones, cargamos la GDT y activamos el bit PE en `CR0`.
- **Bootloader ([boot.asm](file:///home/sergio/work/antigravity/The_low_level_journey/04_protected_mode/boot.asm))**: Orquestamos todo y saltamos a 32 bits.

### 2. Adiós BIOS, Hola VGA RAM
Como en 32 bits no hay interrupciones de BIOS, implementamos `print_string_pm`, que escribe directamente en la dirección física **`0xB8000`**. Ver el mensaje en pantalla es la prueba definitiva de que:
1. La CPU está en modo 32 bits.
2. La segmentación está funcionando.
3. Estamos manejando el hardware a "pelo".
