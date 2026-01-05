# 10. Acceso a Memoria: Los Corchetes `[]`
*Fecha: 5 de Enero, 2026*

Para que la CPU sea útil, debe poder leer y escribir datos en la RAM. En ensamblador x86, esto se hace mediante el uso de corchetes.

### 1. El Concepto de Dirección vs Contenido
*   `mov ax, 0x8000`: Carga el **número** (dirección) 0x8000 en AX.
*   `mov ax, [0x8000]`: Carga el **contenido** de lo que hay guardado en la dirección 0x8000.

Es la diferencia entre tener la dirección de una casa o entrar dentro de la casa a ver qué hay.

### 2. La Limitación Física: No Mem-to-Mem
Una regla fundamental de la arquitectura x86 es que **no puedes mover datos de una dirección de memoria a otra directamente**.

```assembly
mov [0x1234], [0x5678]  ; ¡ERROR!
```

El hardware no tiene un "cable" directo entre dos posiciones de RAM. Siempre debes pasar por un registro intermedio (el "mozo de almacén"):

```assembly
mov al, [0x5678]        ; Paso 1: Cargar en registro
mov [0x1234], al        ; Paso 2: Guardar en destino
```

### 3. Direccionamiento Indirecto
Podemos usar registros (como `BX`, `SI`, `DI`, `BP`) para guardar la dirección a la que queremos acceder. Esto es la base de los **punteros**.

```assembly
mov bx, 0x8000          ; BX apunta a la dirección
mov al, [bx]            ; AL ahora contiene el byte de esa dirección
```

### 4. Definición de Datos en el Código
Para reservar espacio en nuestro programa, usamos directivas:
*   `db`: Define Byte (1 byte)
*   `dw`: Define Word (2 bytes)

```assembly
mi_variable: db '?'     ; Reserva un byte con el valor '?'
```

Si luego hacemos `mov byte [mi_variable], 'S'`, estamos sobreescribiendo ese byte en el binario final cargado en RAM.
