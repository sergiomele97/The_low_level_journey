# 03. ¿Todo acaba en Ensamblador?
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
