# 21. Linker Scripts y Entry Points: El puente a C
*Fecha: 6 de Enero, 2026*

Hemos dado el salto al lenguaje C, pero para que esto funcione sin un sistema operativo debajo, hemos tenido que construir un puente muy específico.

### 1. El problema de la "función main"
En un programa normal de C, la ejecución empieza en `main`. Pero ese `main` no es realmente lo primero que se ejecuta; hay un código oculto (llamado `crt0`) que prepara el entorno. 

Como nosotros no tenemos ese código oculto, hemos creado nuestro propio **Kernel Entry** ([`kernel_entry.asm`](file:///home/sergio/work/antigravity/The_low_level_journey/05_kernel_c/kernel_entry.asm)).
- Este pequeño archivo de Assembly simplemente dice `call kmain`.
- Es lo primero que lee el procesador tras salir del bootloader.

### 2. El Mapa del Tesoro: Linker Scripts
¿Cómo sabe la CPU que el código empieza exactamente en una dirección y no en otra? Para eso usamos el **Linker Script** ([`linker.ld`](file:///home/sergio/work/antigravity/The_low_level_journey/05_kernel_c/linker.ld)).

**¿Por qué usamos la dirección `0x1000`?**
Es una decisión de diseño para evitar conflictos:
- **`0x0000 - 0x0500`**: Reservado para la tabla de vectores de interrupción de la BIOS.
- **`0x7C00`**: Donde vive el Bootloader.
- **`0x1000`**: Es un solar vacío y seguro. Está lejos de los datos críticos de la BIOS y deja espacio suficiente antes del bootloader.

### 3. Cargar desde el Disco
Nuestro Bootloader ahora es más inteligente. Usa la **Interrupción de BIOS 0x13** para leer los sectores del disco que vienen justo después de él (donde hemos pegado nuestro kernel compilado) y meterlos directamente en la RAM en la posición `0x1000`.

---

**Lo que hemos conseguido:**
Tenemos un flujo de trabajo profesional. Escribimos en C, ejecutamos un `make` y el sistema se encarga de ensamblar, compilar, enlazar y crear una imagen de disco `os_image.bin` lista para QEMU.

¡A partir de ahora, la mayor parte de nuestro SO será código C!
