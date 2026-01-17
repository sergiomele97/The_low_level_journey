# RISC-V: Comunicación con el Hardware (Capa 0.1)

Para que nuestro **Ensamblador Nativo** pueda recibir código y decirnos algo, necesita un canal de comunicación. En el mundo Bare Metal, ese canal es la **UART** (consola serie).

En la máquina `virt` de QEMU, la UART se encuentra en la dirección base: `0x10000000`.

## 1. El Registro de Datos (THR/RBR)
- **Dirección**: `0x10000000`
- **Escritura**: El byte que envíes aquí aparecerá en tu terminal.
- **Lectura**: El byte que leas de aquí es una tecla presionada por ti.

## 2. El Registro de Estado (LSR)
- **Dirección**: `0x10000005`
- Bit 0 (`DR` - Data Ready): Si es 1, hay un carácter esperando para ser leído.
- Bit 5 (`THRE` - Transmit Holding Register Empty): Si es 1, podemos enviar un carácter sin perder datos.

## 3. ¿Cómo lo usamos sin C?
En nuestro ensamblador de "papel" usaremos instrucciones de carga y guardado (`LW`, `SW` o `LB`, `SB`).

### Ejemplo: Enviar la letra 'A' (ASCII 65 / 0x41)
1. Cargar la dirección de la UART: `lui t0, 0x10000` (t0 = 0x10000000).
2. Cargar el carácter: `addi t1, zero, 0x41`.
3. Guardar en la UART: `sb t1, 0(t0)`.

Este es el nivel de control que buscamos. Cada letra que veas en la pantalla será porque nosotros hemos movido esos bits a esa dirección de memoria específica.

> [!NOTE]
> **Adiós al C**: Al no usar C, no tenemos `printf`. Cada función de "imprimir texto" o "leer palabra" la escribiremos nosotros en ensamblador puro y la ensamblaremos manualmente la primera vez.
