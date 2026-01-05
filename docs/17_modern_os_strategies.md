# 17. Estrategias de Desarrollo Modernas
*Fecha: 5 de Enero, 2026*

Si alguien hoy decidiera crear un sistema operativo comercial o de alto nivel (como Redox OS o un nuevo kernel para servidores), la estrategia sería radicalmente distinta a la que estamos siguiendo para aprender.

### 1. El Arranque: Usar un Bootloader Estándar
Nadie escribe ya sus propios 512 bytes de boot sector para un producto real. Es peligroso y limitado.
*   **Limine / GRUB / Stivale2**: Se usan protocolos de arranque ya creados.
*   **UEFI**: El SO se diseña para hablar con UEFI, que carga el kernel directamente en 64 bits y en un formato estándar (como ELF).

### 2. El Lenguaje: El ascenso de Rust
Aunque **C** sigue siendo el rey por su cercanía al hardware, **Rust** está ganando la partida en los nuevos SO (ej: Google KataOS, Redox).
*   **Por qué**: Rust evita por diseño los errores de memoria (punteros nulos, desbordamientos) que causan el 70% de los fallos de seguridad en kernels como Linux o Windows.

### 3. La Estrategia: Microkernel vs Monolítico
*   **Monolítico (Linux/Windows)**: Todo el código (drivers, red, sistema de archivos) vive dentro del Kernel. Es muy rápido pero si un driver falla, el PC muere (Pantallazo Azul).
*   **Microkernel (Zircon/Minix)**: El Kernel solo hace lo mínimo (gestión de memoria y procesos). Los drivers son programas normales que corren "fuera". Si el driver de la gráfica falla, el Kernel simplemente lo reinicia. Es mucho más seguro y moderno.

### 4. Resumen Comparativo

| Concepto | Nuestra Ruta (Didáctica) | Ruta Moderna (Producción) |
| :--- | :--- | :--- |
| **Boot** | Legacy BIOS (16-bit) | UEFI + Limine (64-bit) |
| **Lenguaje** | Assembly + C | C++ o Rust |
| **Hardware** | Drivers desde cero | Interfaces estándar (VirtIO, ACPI) |
| **Meta** | Entender el silicio | Crear un sistema seguro y escalable |

**Conclusión:** Nuestra ruta es la mejor para **aprender**, pero la ruta moderna es la necesaria para **competir**.
