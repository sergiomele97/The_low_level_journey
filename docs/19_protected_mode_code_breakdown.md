# 19. Destripando los 32 bits: Paso a Paso
*Fecha: 6 de Enero, 2026*

Para que el cambio a Modo Protegido deje de ser una caja negra, vamos a diseccionar los tres archivos que lo hacen posible.

---

### 1. El Formulario: [`gdt.asm`](file:///home/sergio/work/antigravity/The_low_level_journey/04_protected_mode/gdt.asm)
La CPU exige una tabla de descriptores (GDT) para saber qué permisos tiene cada trozo de memoria.

*   **`gdt_null`**: Son 8 bytes de ceros. Es obligatorio. Si la CPU intenta usar un segmento vacío, saltará un error en lugar de hacer algo impredecible.
*   **`gdt_code`**: El "carnet de identidad" del código.
    *   `Limit`: Le decimos que el segmento mide 4GB (`0xfffff` con una bandera de granuralidad que multiplica por 4096).
    *   `Flags`: Marcamos que es código, que se puede leer y que tiene privilegios de kernel (nivel 0).
*   **`gdt_data`**: Casi igual al de código, pero marcamos el bit de "Executable" a 0. Esto evita que la CPU intente ejecutar variables como si fueran instrucciones.
*   **`gdt_descriptor`**: Este es el puntero que realmente le pasamos a la CPU. Contiene el tamaño de la tabla y su dirección física.

---

### 2. El Ritual: [`switch_pm.asm`](file:///home/sergio/work/antigravity/The_low_level_journey/04_protected_mode/switch_pm.asm)
Aquí es donde ocurre la transformación física de la CPU.

1.  **`cli`**: Apagamos las interrupciones. La BIOS maneja interrupciones de 16 bits; si entrara una mientras estamos a medias del salto, el PC se reiniciaría al instante.
2.  **`lgdt [gdt_descriptor]`**: Le decimos a la CPU: "Mira, aquí tienes el formulario de memoria que me pediste".
3.  **`mov eax, cr0 / or eax, 0x1 / mov cr0, eax`**: Este es el "clic" del interruptor. El registro `CR0` es el cerebro de la CPU. Poner su bit 0 a `1` activa el modo protegido.
4.  **`jmp CODE_SEG:init_pm`**: El **Far Jump**. Es vital. Como la CPU lee instrucciones por adelantado, tiene la cola llena de código de 16 bits. Al saltar a una dirección lejana, la CPU se ve obligada a vaciar la cola y empezar de cero, ya interpretando todo como 32 bits.

---

### 3. El Despertar: [`boot.asm`](file:///home/sergio/work/antigravity/The_low_level_journey/04_protected_mode/boot.asm)
El orquestador de todo.

*   **`[bits 16]`**: Empezamos en el pasado. Inicializamos los registros (`ds`, `es`...) a 0 para que no haya basura.
*   **VGA RAM (`0xB8000`)**: En lugar de llamar a la BIOS (`int 0x10`), escribimos directamente en una dirección de memoria mágica.
    *   A partir de `0xB8000`, la tarjeta de vídeo lee lo que hay ahí y lo dibuja en pantalla.
    *   Cada carácter ocupa 2 bytes: el **código ASCII** y el **atributo** (color). 
    *   Por eso sumamos `2` a `EDX` en cada iteración del bucle de impresión.

---

**Resumen del Flujo:**
`Encendido` -> `16 bits` -> `Cargar GDT` -> `Activar CR0` -> `Salto Largo` -> `32 bits` -> `Escritura Directa en VGA`.

¡Ya no hay magia, solo registros y memoria!
