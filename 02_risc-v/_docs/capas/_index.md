# RISC-V: La Escalera de Abstracción

Este índice define las capas que construiremos nosotros mismos, partiendo desde el silicio puro hasta un sistema operativo funcional.

## Capas del Sistema

| Capa | Nombre | Descripción | Estado |
| :--- | :--- | :--- | :--- |
| **[Capa 0](capa_0_isa/README.md)** | **Silicio e ISA** | El manual oficial de instrucciones (RV32I) y los registros. | ✅ Documentado |
| **[Capa 1](capa_1_io/README.md)** | **Hardware I/O** | Comunicación con el mundo (UART) y mapa de memoria. | ✅ Documentado |
| **[Capa 2](capa_2_tools/README.md)** | **Herramientas Base** | Nuestro Ensamblador Nativo y utilidades de construcción. | 🛠️ En Proceso |
| **Capa 3** | **Bootloader** | El primer código que se ejecuta y prepara el entorno. | ⏳ Pendiente |
| **Capa 4** | **El Kernel** | Gestión de recursos. | ⏳ Pendiente |

---

## 🏁 Manifiesto de la Pureza Absoluta

Para que este proyecto sea verdaderamente "nuestro", seguimos estas reglas inquebrantables:

1. **Sin Herramientas Externas**: No usaremos Python ni GCC para generar el código final.
2. **Bootstrapping**: Cada herramienta debe ser capaz de ser construida por una versión anterior más simple, empezando por el Hexadecimal manual.
3. **QEMU como Silicio**: Aceptamos QEMU como nuestra placa base física virtual, pero nada más.

> [!IMPORTANT]
> **Regla de Oro**: Ninguna capa puede usar una herramienta que no haya sido construida en una capa inferior.
