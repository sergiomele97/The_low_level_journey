# Log 00: ¿Qué es RISC-V y qué es la UART?

Para entender lo que estamos haciendo, olvida todo lo que sabes de "programación" moderna. Vamos a pensar en tuberías y cajones.

## 1. ¿Cómo funciona RISC-V (simplificado)?
Imagina que el procesador es una **oficina** con:
- **32 Cajones (Registros)**: Llamados `x0` a `x31`. Solo caben números de 32 bits.
- **Un Oficinista (La CPU)**: Que solo sabe leer una lista de instrucciones (tu código).
- **Un Puntero (PC - Program Counter)**: El dedo del oficinista que señala qué instrucción de la lista debe leer ahora.

### El flujo es siempre el mismo:
1. El oficinista mira el **PC**.
2. Lee el número de 32 bits que hay en esa dirección de memoria.
3. Lo "decodifica": según los ceros y unos, sabe si tiene que sumar, mover datos o saltar a otra línea.
4. Ejecuta la orden y mueve el **PC** a la siguiente línea (o adonde diga el salto).

**¿Por qué es especial RISC-V?**
Porque es muy honesto. No tiene modos ocultos raros de hace 40 años. Es un set de instrucciones moderno y limpio diseñado para ser eficiente y fácil de entender.

---

## 2. ¿Qué es la UART?
La **UART** (Universal Asynchronous Receiver-Transmitter) es el hardware más simple que existe para que un ordenador hable con otro (o contigo).

### Imagínalo así:
Es un **buzón físico** en una dirección concreta de la memoria (`0x10000000`).
- Si quieres que aparezca algo en la pantalla de tu host, le das al "oficinista" (CPU) un papel que diga: *"Pon el número 90 (la letra Z) en el buzón de la calle 0x10000000"*.
- El hardware de la UART detecta que hay algo en el buzón y lo envía por un "cable" virtual hasta tu terminal.

### ¿Por qué lo usamos?
Porque el procesador, por sí solo, no tiene pantalla ni teclado. Es un cerebro en un tanque de cristal. La UART es nuestro **primer cable al mundo exterior**. Sin ella, no sabríamos si el procesador está vivo o si se ha colgado.

---

## Resumen:
- **RISC-V**: El cerebro que mueve números entre cajones (registros).
- **Instrucciones**: Los ceros y unos que le dicen al cerebro qué cajón abrir.
- **UART**: El buzón de correo que usamos para sacar información del cerebro a tu pantalla.

¡Ahora todo lo que hemos hecho en los logs anteriores (codificar bits de ADDI, LUI...) debería tener más sentido!
