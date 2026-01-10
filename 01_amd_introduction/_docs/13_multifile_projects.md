# 13. Escalando: Proyectos Multificado y "Librerías"
*Fecha: 5 de Enero, 2026*

A medida que un programa en Ensamblador crece, tener miles de líneas en un solo archivo es una receta para el desastre. Aunque no tenemos un `npm` o `pip`, tenemos herramientas para organizar el caos.

### 1. La Directiva `%include`
En NASM, la forma más sencilla de dividir el código es usar `%include`. Funciona como un "copiar y pegar" automático antes de compilar.

**Ejemplo:**
Tenemos `util.asm`:
```assembly
print_char:
    mov ah, 0x0e
    int 0x10
    ret
```

Y nuestro `main.asm`:
```assembly
[org 0x7c00]
%include "util.asm"

start:
    mov al, 'A'
    call print_char
    jmp $
```

### 2. ¿Existen las "Librerías"?
En el sentido moderno (descargar un paquete y usarlo), **no**. En ensamblador "bare metal", tú eres el dueño de todo.
Sin embargo, los programadores suelen acumular sus propios archivos de utilidades (`math.asm`, `video.asm`, `keyboard.asm`) que van incluyendo en sus proyectos.

### 3. El Linker (Enlazador)
En proyectos profesionales (como el Kernel de Linux o drivers complejos), no se usa `%include` para todo.
1. Se compilan archivos por separado a **ficheros objeto** (`.o`).
2. Un programa llamado **Linker** (como `ld`) une todos esos `.o` en un solo binario final.
Esto permite mezclar archivos hechos en **Ensamblador** con archivos hechos en **C**.

### 4. ¿Se escriben programas largos hoy?
*   **Ayer:** Sí. Juegos de los 80 y 90 (como *RollerCoaster Tycoon*) se escribieron casi al 100% en ensamblador. 
*   **Hoy:** Muy raro. Se usa solo para las partes donde el compilador de C no puede llegar o para el arranque (bootloaders).

**Regla de oro:** Si puedes hacerlo en C, hazlo en C. Si necesitas tocar un registro específico o una instrucción especial de la CPU, usa Ensamblador.
