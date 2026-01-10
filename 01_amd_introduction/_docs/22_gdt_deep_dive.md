# 22. El Mapa de Permisos: GDT Deep Dive
*Fecha: 6 de Enero, 2026*

La **GDT (Global Descriptor Table)** es la estructura que permite al procesador x86 pasar de los limitados 16 bits al Modo Protegido de 32 bits.

### 1. La Matemática de los 32 bits
¿Por qué el límite de memoria en 32 bits es de **4 GB**? 
- Un registro de 32 bits puede formar $2^{32}$ combinaciones únicas.
- $2^{32} = 4,294,967,296$ direcciones de memoria.
- Como cada dirección apunta a 1 byte: tenemos un límite físico de **4 Gigabytes**.

### 2. ¿Qué es la GDT técnicamente?
No es una abstracción de software, es una **tabla física en la RAM** que la CPU consulta en cada ciclo de reloj. Contiene "Descriptores de Segmento" (entradas de 8 bytes) con tres datos clave:
- **Base**: Dirección de inicio (ej. `0x00000000`).
- **Límite**: Tamaño del segmento (ej. `0xFFFFFFFF` para 4GB).
- **Acceso/Privilegios**: Define si es Código o Datos, y el nivel de privilegio (**Ring 0** para el Kernel, **Ring 3** para programas).

### 3. El Modelo de Memoria Plana (Flat Memory Model)
En nuestro kernel actual, hemos configurado la GDT de una forma especial:
- Hemos creado un **Segmento de Código** (0 a 4GB).
- Hemos creado un **Segmento de Datos** (0 a 4GB).
- Ambos tienen **Privilegio 0 (Administrador)**.

Al solapar ambos segmentos sobre toda la RAM disponible, le decimos a la CPU: *"No me particiones la memoria todavía; déjame acceder a todo el terreno con permiso total"*. Esto es necesario porque el hardware de 32 bits exige una GDT para funcionar, aunque sea para darnos permiso total.

### 4. ¿Cómo lo sabe la CPU?
Usamos la instrucción `lgdt` para cargar la dirección de esta tabla en un registro interno de la CPU llamado **GDTR**. A partir de ese "clic", la CPU ya no usa direcciones directas, sino que consulta nuestra tabla para cada acceso a memoria.

**En resumen:** La GDT es el contrato legal entre tu código y el hardware. Tú escribes las reglas en la RAM, y la CPU las hace cumplir.
