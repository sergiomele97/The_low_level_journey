# The Low Level Journey - Dev Log

## 00. El Inicio: Herramientas del Oficio
*Fecha: 4 de Enero, 2026*

Para comenzar a construir un Sistema Operativo desde cero, necesitamos bajar al metal. No nos sirven los compiladores complejos ni los entornos visuales por ahora. Necesitamos control total sobre cada byte.

### Aprendizajes

#### 1. NASM (Netwide Assembler)
¿Por qué no usar el ensamblador de GCC (`as`)? Porque NASM es más "honesto".
*   **Lo que hace:** Traduce nuestras instrucciones en ensamblador (mnemónicos como `MOV`, `JMP`) directamente a código máquina (binario puro).
*   **La ventaja:** Nos permite generar archivos "flat binary" (binarios planos) sin cabeceras extrañas que Linux o Windows necesitan para ejecutar programas (.exe, .elf). Un SO en su arranque es solo un chorro de bytes en el disco, y NASM nos deja crear exactamente eso.

#### 2. QEMU (Quick Emulator)
Probar un SO en hardware real es lento (copiar a USB, reiniciar, rezar).
*   **Lo que hace:** Emula un PC completo por software (CPU, RAM, Disco, Pantalla).
*   **La ventaja:** Nos permite ejecutar nuestro archivo binario como si fuera un disco duro de arranque. Es nuestro laboratorio de pruebas seguro. Si el código falla y "cuelga" la CPU, solo cerramos la ventana.

#### 3. Ensamblador, Mnemónicos y la Máquina
Es crucial entender la jerarquía:
*   **Código Máquina:** `B8 04 00` (Lo que la CPU come. Voltajes).
*   **Ensamblador (Lenguaje):** `MOV AX, 4` (Mnemónicos legibles por humananos).
*   **Ensamblador (Programa):** `NASM`. El traductor que convierte `MOV AX, 4` -> `B8 04 00`.

#### 4. Binario vs Hexadecimal
Son lo mismo, solo cambia la representación. El Hexadecimal es una compresión visual del binario, usada porque leer `10111000` duele.
*   `1011` (Bin) = `B` (Hex)
*   `1000` (Bin) = `8` (Hex)
*   `10111000` = `0xB8`

#### 5. x86 (La Arquitectura)
Es el "idioma nativo" de nuestro procesador (Intel/AMD).
*   Un chip **ARM** (Móvil) no entiende x86.
*   Nosotros escribiremos instrucciones para x86 (`MOV`, `JMP`) porque estamos desarrollando para PC.

---
## 01. El Primer Aliento: Boot Sector
*Fecha: 4 de Enero, 2026*

Hemos escrito nuestro primer programa "Bare Metal". Sin sistema operativo debajo que nos ayude. Somos nosotros, la CPU y la BIOS.

### El Código (`boot.asm`)
Nuestro programa hace lo siguiente:
1.  **`[org 0x7c00]`**: Le decimos a NASM que la BIOS nos cargará en la dirección de memoria `0x7C00`. Si no ponemos esto, nuestros punteros a variables estarían mal calculados.
2.  **`MOV AH, 0x0E`**: Preparamos el registro AH para decirle a la BIOS "Quiero imprimir un carácter en modo teletipo".
3.  **El Bucle**:
    *   Leemos un carácter de nuestro mensaje.
    *   Comprobamos si es 0 (el final, como en C).
    *   Si no es 0, ejecutamos `INT 0x10` (¡La llamada a la BIOS!).
    *   Repetimos.
4.  **`JMP $`**: Un bucle infinito al final. Si la CPU siguiera ejecutando instrucciones más allá de nuestro código, se encontraría con memoria basura y probablemente se reiniciaría o haría cosas raras. Aquí la "congelamos".
5.  **La Magia (`0xAA55`)**: Rellenamos con ceros hasta el byte 510 y ponemos `AA 55` al final. Sin esto, la BIOS diría "No bootable device found".

### Compilación y Ejecución
```bash
nasm -f bin boot.asm -o boot.bin
qemu-system-x86_64 boot.bin
```
El resultado: Una ventana negra con "Hello Low Level World!".
Estado: **ÉXITO**.

---

## 02. Arquitecturas: La Torre de Babel
*Fecha: 4 de Enero, 2026*

¿Si todo es binario, por qué mi programa de PC no funciona en mi móvil? La respuesta son las **ISAs (Instruction Set Architectures)**.

### ¿Son "idiomas" diferentes?
Sí. Absolutamente.
Igual que el español y el inglés usan el mismo alfabeto (Binario/Hex) pero combinan las letras de forma diferente para dar significado:

1.  **x86 / x86_64 (Intel & AMD)**
    *   **Dónde vive:** En tu PC, en la nube, en las consolas (PlayStation/Xbox).
    *   **Filosofía (CISC):** "Complicated Instruction Set". Tiene miles de instrucciones. Una sola instrucción puede hacer cosas muy locas y complejas.
    *   **Ejemplo:** Es como el *Alemán*, palabras largas y muy específicas con mucha historia detrás.

2.  **ARM (arm64 / AArch64)**
    *   **Dónde vive:** En tu móvil (Android/iPhone), en tu tablet, en los nuevos Macs (M1/M2/M3) y en la Raspberry Pi.
    *   **Filosofía (RISC):** "Reduced Instruction Set". Instrucciones más simples y uniformes. Para hacer algo complejo, combinas varias simples.
    *   **Ejemplo:** Es como el *Inglés*, gramática más simple y estructurada.

3.  **RISC-V**
    *   **Dónde vive:** En microcontroladores baratos y en el futuro.
    *   **Filosofía:** Open Source. Es como el *Esperanto* o *Linux* de los procesadores. Cualquiera puede fabricar un chip RISC-V sin pagar patentes.

### La Torre de Babel Binaria
Si le das el código máquina de x86 (`B8 05 00` -> Mover 5 a AX) a un procesador ARM:
*   El procesador ARM leerá `B8` y pensará que es una instrucción totalmente distinta (quizás una suma, o un error).
*   **Resultado:** El programa explota. Por eso necesitamos recompilar los programas para cada arquitectura.


## 03. ¿Todo acaba en Ensamblador?
*Fecha: 4 de Enero, 2026*

**Pregunta del día:** "Mi código de React o Python... ¿también se convierte en ensamblador?"

**Respuesta Corta:** Sí. Absolutamente todo lo que ejecuta la CPU son instrucciones de código máquina (que es el primo numérico del ensamblador).

**Respuesta Larga (El Embudo):**

1.  **Lenguajes Compilados (C, Rust, Go):**
    *   `Tu Código` -> `Compilador` -> `Ensamblador` -> `Binario`.
    *   Aquí la traducción es directa antes de ejecutar.

2.  **Lenguajes Interpretados (Python):**
    *   `Tu Script` -> `Bytecode (.pyc)` -> `Máquina Virtual de Python` -> `Binario`.
    *   Truco: La "Máquina Virtual" es un programa compilado (hecho en C) que traduce tus deseos a instrucciones de CPU en tiempo real. Al final, siempre hay alguien hablando en ensamblador con la CPU.

3.  **Lenguajes JIT (JavaScript en V8, Java):**
    *   Empiezan interpretando, pero si una función se usa mucho, el motor (V8) la compila a **Código Máquina nativo** al vuelo para que vaya rápido.
    *   Por eso Chrome consume tanta RAM: está compilando tu React a ensamblador en tiempo real.

### La Ley del Silicio
La CPU no sabe qué es un `<div>` o un `def main():`. Solo sabe `MOV`, `ADD`, `JMP`.
Si pudieras congelar el tiempo y mirar la CPU mientras corres React, verías millones de `MOV` y `CMP` ocurriendo frenéticamente.

### Ingeniería Inversa (Disassembly)
Como la traducción es 1:1, **sí, todo binario se puede traducir a ensamblador**.
Herramientas como `objdump` o `Ghidra` cogen un `.exe` o el kernel de Linux y te escupen el ensamblador. No recuperas los nombres de variables (se pierden), pero recuperas la lógica exacta.

## 04. El Misterio de los Nombres Perdidos (Symbols)
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

## 05. El Fantasma en la Máquina: ¿Dónde "vive" el ensamblador?
*Fecha: 4 de Enero, 2026*

**Pregunta:** "¿Dónde está guardado físicamente que `0xB8` significa `MOV`?"

**Respuesta:** No está guardado como software. Está esculpido en silicio. Está "hard-wired".

### 1. El Decodificador (Decoder)
Imagina el chip como un laberinto de tuberías de agua.
*   Cuando entra el byte `10111000` (`0xB8`), el agua (electricidad) fluye por un camino específico de puertas lógicas (`AND`, `OR`) que acaba activando la señal: "¡Abre la puerta del registro AX y mete el dato!".
*   Si entra otro byte, el circuito físico desvía la electricidad por otro camino.
*   **Diferencia x86 vs ARM:** El laberinto de x86 es barroco y caótico. El de ARM es limpio y simétrico.

### 2. Microcódigo (El secreto de Intel)
Las instrucciones de x86 son tan complejas hoy en día que no se pueden cablear directamente.
Dentro de tu i7 o Ryzen hay... **¡otra mini-CPU oculta!**
*   Cuando mandas una instrucción compleja de x86, el hardware la traduce internamente a **Micro-Operaciones (uops)** super simples.
*   Esas `uops` son las que realmente mueven los electrones.
*   Es decir: Tu CPU moderna es un núcleo RISC disfrazado de CISC mediante una capa de traducción de hardware llamada **Microcódigo**.

## 06. x86: 40 Años de Deuda Técnica
*Fecha: 4 de Enero, 2026*

**Verdad:** Has dado en el clavo. x86 es la definición de deuda técnica acumulada.
Cuando enciendes tu i9 último modelo, *arranca fingiendo ser un chip 8086 de los años 70*.
*   Arranca en 16-bits (Real Mode).
*   Tiene limitaciones absurdas de memoria.
*   Intel **no puede quitar esto** porque rompería todo el software antiguo (MS-DOS, Windows 95).

**Nombre Correcto:** Al "idioma" no lo llamamos ensamblador (ese es el texto humano), lo llamamos **ISA (Instruction Set Architecture)**.


## 07. Escuchando al Usuario: Teclado y BIOS
*Fecha: 4 de Enero, 2026*

Hemos logrado interactividad. Una pantalla negra que repite lo que escribimos.

### El Mecanismo: Polling a la BIOS
Hemos usado la interrupción **`INT 0x16`**, función `AH=0x00` (Blocking Read).
*   **Cómo funciona:** La CPU se "congela" en esa instrucción hasta que el chip del teclado le dice "¡Eh, han pulsado la 'A'!".
*   **ASCII vs Scan Codes:**
    *   La BIOS nos devuelve la letra traducida ('A' = 65) en el registro `AL`.
    *   Pero también nos da el "Scan Code" (la posición física de la tecla) en `AH`.

### El Misterio de las Flechas
Has notado algo raro: "Las flechas borran o hacen cosas raras".
**La Razón:** Las flechas no son caracteres ASCII imprimibles. Cuando pulsas "Flecha Arriba", la BIOS pone un `0` en `AL` y el código de la flecha en `AH`.
Al intentar imprimir `AL` (que es 0 o basura) con `INT 0x10`, la BIOS intenta interpretar ese 0. A veces lo ignora, a veces imprime un espacio, a veces mueve el cursor hacia atrás.
Para arreglar esto, tendríamos que leer `AH` (Scan Code) y decir "Si es flecha arriba, no imprimas nada, mueve el cursor". ¡Bienvenido al mundo de los Drivers!

