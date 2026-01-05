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

### 4. Preguntas Frecuentes del Metal

**¿Qué es el Real Mode exactamente?**
Es el modo "borracho" de la CPU. Emula a un procesador de 1978 (el 8086). No tiene seguridad: cualquier programa puede escribir en la memoria del kernel o incluso apagar el PC. Solo puede ver **1 MB** de RAM (una miseria hoy en día).

**¿Por qué se llama Protected Mode?**
Porque introduce muros. En este modo, el hardware (la CPU) impide que un programa acceda a la memoria de otro. Si intentas escribir donde no debes, la CPU lanza una "General Protection Fault" y mata el proceso. Esto es lo que permite que tu PC no se cuelgue entero cuando falla una pestaña de Chrome.

**¿Por qué nosotros no podemos arrancar directamente en 64 bits?**
Porque estamos usando el camino de la **Legacy BIOS**. Por diseño, la BIOS de Intel resetea la CPU al modo de 1978 (16 bits) para asegurar que *cualquier* sistema operativo antiguo pueda arrancar. 

Es como una escalera obligatoria: 
1. La BIOS te deja en el primer escalón (16 bits).
2. Tienes que subir al segundo (32 bits) para poder ver la configuración de 64 bits.
3. Desde los 32 bits, activas la paginación y haces otro salto al tercero (64 bits).

**No hay un "salto" directo de 16 a 64.** La CPU simplemente no tiene las "instrucciones" preparadas en el primer escalón para entender qué es un registro de 64 bits.

### 5. ¿Hacen esto Linux y Windows?
La respuesta corta es: **Antes sí, ahora no tanto.**

*   **Era BIOS (Legacy)**: Linux y Windows usaban un **Bootloader** (como GRUB o NTLDR). El bootloader empezaba en 16 bits, hacía exactamente este "baile" de la GDT y la A20, y luego saltaba al Kernel ya en modo protegido.
*   **Era UEFI (Moderno)**: Los PCs actuales usan UEFI en lugar de BIOS. La UEFI es mucho más inteligente: ella misma inicializa la CPU directamente en **64 bits (Long Mode)** y le pasa al Sistema Operativo un entorno ya preparado. Nos ahorra todo este lío, pero... ¡le quita la gracia de entender cómo funciona el silicio!

### 6. Desmitificando el "Código Mágico"
He añadido cosas que parecen "cajas negras", pero tienen una explicación histórica muy humana:

1.  **Inicialización de Segmentos (`xor ax, ax / mov ds, ax`)**:
    En 16 bits, la memoria se calcula como `Segmento * 16 + Offset`. Si la BIOS nos deja basura en los registros de segmento, nuestra dirección `0x7c00` podría acabar apuntando a cualquier sitio. Ponerlos a cero garantiza que `0 * 16 + 0x7c00` sea exactamente la dirección física `0x7c00`. Limpiamos la mesa antes de empezar.

2.  **La Línea A20 (`in al, 0x92...`)**:
    Es un "truco" de compatibilidad del año 1984. Los antiguos PCs tenían un error que hacía que las direcciones de memoria "rebotaran" al llegar a 1MB. Para no arreglar el error (y que los programas viejos no fallaran), pusieron un interruptor físico para habilitar/deshabilitar el **Bit 20** de las direcciones. Si no lo activamos, la CPU se queda "ciega" para acceder a la RAM por encima de 1MB.

3.  **La GDT (Global Descriptor Table)**:
    No es una abstracción, es el **contrato obligado** por Intel. Para entrar en 32 bits, la CPU *exige* que le digas dónde están los trozos de memoria y qué permisos tienen. Sin este mapa, la CPU se niega a cambiar de modo.

### 7. Hablar con el Mundo sin la BIOS (Pintando Pixeles)
...
