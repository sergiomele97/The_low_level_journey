# 07. Escuchando al Usuario: Teclado y BIOS
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
