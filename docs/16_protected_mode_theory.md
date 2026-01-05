# 16. La Frontera: 32-bit Protected Mode
*Fecha: 5 de Enero, 2026*

Hemos llegado al final de la infancia del sistema operativo. Hasta ahora, hemos vivido en el **Real Mode (16 bits)**, un lugar nostálgico pero extremadamente limitado. Es hora de romper las cadenas.

### 1. ¿Qué es el Protected Mode?
Es el modo de operación nativo de los procesadores x86 modernos (aunque ya estamos en 64 bits, los 32 bits fueron el gran salto).

| Característica | Real Mode (16 bits) | Protected Mode (32 bits) |
| :--- | :--- | :--- |
| **Registros** | 16 bits (`AX`, `BX`...) | 32 bits (`EAX`, `EBX`...) |
| **RAM Máxima** | 1 MB | 4 GB |
| **Protección** | Ninguna (puedes romperlo todo) | Segmentación y Paginación (Privacidad) |
| **Interrupciones** | BIOS (`int 0x10`, etc.) | **¡No funcionan!** (Hay que crear las nuestras) |

### 2. El GDT (Global Descriptor Table)
En 32 bits, los registros de segmento (`CS`, `DS`, `SS`) ya no contienen una dirección base. Ahora contienen un **índice** a una tabla gigante llamada **GDT**.
Esta tabla define:
*   Dónde empieza cada segmento de memoria.
*   Qué tamaño tiene.
*   Quién tiene permiso para usarlo (Privilegios).

### 3. El Salto al Vacío (La Transición)
Para pasar de 16 a 32 bits, hay que seguir este ritual sagrado:
1.  **Desactivar Interrupciones (`cli`)**: No queremos que la BIOS intente hacer nada mientras cambiamos el cerebro de la CPU.
2.  **Cargar la GDT (`lgdt [gdt_descriptor]`)**: Darle a la CPU el mapa de la RAM de 32 bits.
3.  **Encender el interruptor (`CR0`)**: Hay un registro especial llamado `CR0`. Si ponemos su primer bit a `1`, la CPU entra en modo 32 bits.
4.  **Limpiar la tubería (Far Jump)**: La CPU tiene instrucciones de 16 bits en cola. Hacemos un salto a una dirección lejana para que la CPU vacíe su cola y empiece a leer en 32 bits.

### 4. Hablar con el Mundo sin la BIOS
Como en 32 bits las interrupciones de la BIOS mueren, ¿cómo pintamos en pantalla?
Escribimos directamente en la **Memoria VGA**.
*   La dirección **`0xB8000`** es pintura mágica.
*   Si escribes un byte ahí, aparece un carácter en la esquina superior izquierda de tu monitor real.

¡Estamos a un paso de tener el control absoluto del hardware!
