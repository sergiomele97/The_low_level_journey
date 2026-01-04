# 02. Arquitecturas: La Torre de Babel
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
