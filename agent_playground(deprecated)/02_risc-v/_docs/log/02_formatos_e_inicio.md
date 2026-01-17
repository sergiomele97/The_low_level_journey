# Log de Aprendizaje: Descifrando los Formatos de Instrucción

*Fecha: 10 de Enero, 2026*

## ¿Qué son los Formatos de Instrucción?
En RISC-V, una instrucción es simplemente un número de **32 bits**. Imagina que tienes una caja de 32 compartimentos. Los "Formatos" son las plantillas que nos dicen qué poner en cada compartimento.

### ¿Por qué hay varios?
Porque no todas las instrucciones necesitan lo mismo.
- Un `ADD` necesita dos registros de origen y uno de destino. (**Tipo-R**)
- Un `ADDI` necesita un registro, un número pequeño (inmediato) y un destino. (**Tipo-I**)
- Un salto necesita una dirección de memoria (un número grande). (**Tipo-J**)

### La genialidad del diseño:
Si miras el manual de la Capa 0, verás que el compartimento de los **registros** (`rd`, `rs1`, `rs2`) siempre está en el mismo sitio. Esto permite que el hardware (o nosotros, al ensamblar a mano) sepa dónde buscar la información sin volverse loco.

## ¿Qué podemos hacer conociendo solo esto?
Conocer los formatos es como conocer las piezas de un puzzle. Con solo esto podemos:
1. **Inyectar Código**: Podemos escribir números en un archivo y que la CPU los ejecute.
2. **Hablar con el Mundo**: Si sabemos la dirección de la UART (`0x10000000`), podemos usar el formato **Tipo-U** (para cargar la dirección) y el **Tipo-S** (para enviar caracteres).

## Nuestro Primer Paso Práctico
Vamos a diseñar un programa de 4 o 5 instrucciones que:
1. Cargue la dirección de la UART en un registro.
2. Cargue el código ASCII de una letra.
3. Lo envíe a la UART.
4. Repita.

**El reto:** Tendremos que calcular a mano cuántos ceros y unos van en cada uno de los 32 compartimentos para que la CPU lo entienda.
