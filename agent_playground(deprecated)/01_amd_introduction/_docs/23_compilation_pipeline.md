# 23. La Fábrica de Software: Puzzles y Pegamento
*Fecha: 6 de Enero, 2026*

Compilar un Sistema Operativo es distinto a compilar un programa normal. Aquí es donde los archivos `.o`, `.ld` y `.bin` entran en juego.

### 1. ¿Qué es un archivo `.o` (Object File)?
Cuando ejecutas `gcc -c kernel.c`, obtienes un `kernel.o`. 
- **Es un binario, pero es "incompleto"**. Está en formato ELF (Executable and Linkable Format).
- **Contiene metadatos**: Dentro del `.o` hay tablas que dicen: *"Aquí empieza la función kmain"* o *"Aquí necesito llamar a una función que no sé dónde está"*.
- **Direcciones relativas**: Las direcciones de memoria no son finales. Es como un trozo de puzzle que aún no ha sido encajado en el tablero. No puedes dárselo a la CPU directamente porque la CPU no entiende de "tablas de símbolos", solo entiende de instrucciones puras.

### 2. El Mapa del Tesoro: Linker Script (`.ld`)
El archivo [**`linker.ld`**](file:///home/sergio/work/antigravity/The_low_level_journey/05_kernel_c/linker.ld) es el plano de construcción. Sin él, el enlazador (Linker) pondría las piezas en cualquier sitio. 
Le indica al Linker:
1. **Entry Point**: Cuál es la primera instrucción (en nuestro caso, lo que hay en `kernel_entry.asm`).
2. **Memory Layout**: En qué dirección exacta de la RAM va cada sección. Nosotros le decimos que empiece en `0x1000`.

### 3. El Enlazado: De `.o` a `.bin`
El **Linker** (`ld`) coge todos los `.o` y usa el `.ld` para:
1. Resolver direcciones (ahora todas las llamadas a funciones tienen una dirección real).
2. **Eliminar metadatos**: Al usar la bandera `--oformat binary`, el Linker tira a la basura toda la información ELF (nombres de funciones, tablas, debug info) y deja solo la **instrucciones puras**.

### 4. ¿Qué diferencia hay entre `.o` y `.bin`?
| Característica | Archivo Objeto (`.o`) | Binario Plano (`.bin`) |
| :--- | :--- | :--- |
| **Formato** | ELF (Estructurado) | Raw (Crudo) |
| **Contenido** | Código + Metadatos + Símbolos | Solo Código y Datos |
| **Ejecutable** | Solo por un OS (como Linux) | Por la CPU directamente (Bare Metal) |
| **Direcciones** | Relativas / Sin definir | Absolutas y finales |

**En resumen:** El `.o` es una pieza de puzzle con instrucciones de uso; el `.bin` es el puzzle ya montado y pegado, listo para ser entregado a la CPU.
### 5. El Equipo de Construcción
Para unir todas las piezas, usamos un equipo coordinado:
- **`gcc`**: El chef que convierte el código C en objetos `.o`.
- **`nasm`**: El carpintero que convierte el Assembly en objetos `.o`.
- **`ld` (Linker)**: El arquitecto que une los `.o` usando el script `.ld` para crear el `kernel.bin`.
- **`cat`**: El obrero que simplemente pega el `boot.bin` y el `kernel.bin` uno tras otro para crear la imagen de disco final.
