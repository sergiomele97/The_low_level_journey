# 04. El Misterio de los Nombres Perdidos (Symbols)
*Fecha: 4 de Enero, 2026*

**Pregunta:** "¿Por qué desaparecen mis nombres de variables al compilar? ¿Y cómo funciona el Debugger entonces?"

### La Amnesia de la CPU
Cuando escribes:
```c
int contador = 5;
```
El compilador decide que `contador` vivirá en la dirección de memoria `0x1004`.
En el binario final, la instrucción será algo como: "Pon un 5 en `0x1004`".
**La palabra "contador" se borra.** A la CPU no le importan tus nombres, solo direcciones numéricas. Esto hace el programa más pequeño y rápido.

### Entonces, ¿cómo debuggeamos? (La Magia de los Símbolos)
Si todo son números, ¿cómo sabe VS Code que `0x1004` es `contador`?
Porque cuando compilas en modo "Debug" (`gcc -g`), el compilador genera un archivo extra (o una sección oculta en el binario) llamada **Tabla de Símbolos** (DWARF en Linux, .PDB en Windows).

Esta tabla es un mapa del tesoro:
*   `0x1004` -> "contador" (int)
*   `0x5000` -> "función_principal"

**El Debugger (GDB)** carga esa tabla y te miente piadosamente: tú le dices "muéstrame contador", él busca en la tabla "ah, quiere `0x1004`", lee esa memoria y te muestra el valor.

### Ingeniería Inversa (Sin Mapa)
Cuando hackeas un juego o analizas un virus, **no tienes la tabla de símbolos**.
Solo ves `MOV [0x1004], 5`.
¿Qué es `0x1004`? ¿Vidas? ¿Munición? Tienes que adivinarlo por el contexto. Es el verdadero "Hard Mode".
