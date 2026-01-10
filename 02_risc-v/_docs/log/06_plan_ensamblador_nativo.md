# Log 06: El Plan del Ensamblador Nativo

*Fecha: 10 de Enero, 2026*

Si queremos un sistema puro, nuestro ensamblador no puede ser un script de Python. Debe ser un programa que corra en RISC-V. Pero, ¿cómo escribimos ese programa si aún no tenemos el ensamblador?

## La Estrategia de la Escalera (Self-Hosting)

1. **v0 (Fase Hex)**: Escribimos un ensamblador "tonto" directamente en hexadecimal. Tan tonto que solo entienda, por ejemplo, `LUI` y `ADDI`.
2. **v1 (Fase Nativa)**: Usamos la **v0** para escribir un ensamblador mejor (con etiquetas, comentarios y más instrucciones).
3. **v2 (Fase Final)**: Usamos la **v1** para escribir el ensamblador definitivo que se usará para el Kernel.

## ¿Qué debe hacer el Ensamblador Mínimo (v0)?
Su única misión es leer caracteres por la UART y convertirlos en números.

### El Reto de las Etiquetas:
Un ensamblador "de verdad" permite poner nombres a las direcciones (como `loop:`). Esto requiere **dos pasadas**:
1. Una para saber dónde está cada nombre.
2. Otra para escribir los saltos finales.

**Decisión**: Para la v0, pasaremos de etiquetas. Calcularemos los saltos a mano. Queremos algo que simplemente nos quite el trabajo de convertir `ADDI t1, zero, 65` a bits.

### Estructura de Entrada:
Queremos enviarle por serie algo como:
`00100293` (un hex directo) o, si somos ambiciosos, que entienda comandos cortos.

*Próxima discusión: ¿Cómo lee el proceso de RISC-V lo que yo escribo en mi teclado?*
