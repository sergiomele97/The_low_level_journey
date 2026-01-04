# 06. x86: 40 Años de Deuda Técnica
*Fecha: 4 de Enero, 2026*

**Verdad:** Has dado en el clavo. x86 es la definición de deuda técnica acumulada.
Cuando enciendes tu i9 último modelo, *arranca fingiendo ser un chip 8086 de los años 70*.
*   Arranca en 16-bits (Real Mode).
*   Tiene limitaciones absurdas de memoria.
*   Intel **no puede quitar esto** porque rompería todo el software antiguo (MS-DOS, Windows 95).

**Nombre Correcto:** Al "idioma" no lo llamamos ensamblador (ese es el texto humano), lo llamamos **ISA (Instruction Set Architecture)**.

**Conclusión:** La ISA está construida físicamente en la **Decode Unit**. Es hardware. Si quieres cambiar la ISA (el idioma), tienes que fabricar un chip nuevo. No puedes "parchear" los transistores (salvo la trampa del microcódigo).
