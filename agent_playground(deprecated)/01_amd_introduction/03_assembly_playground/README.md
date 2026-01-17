# Assembly Playground: Retos

Bienvenido al gimnasio. Aquí tienes una serie de retos para entrenar tu lógica de bajo nivel.
Usa la plantilla `template.asm` como base (ya tiene la configuración de arranque lista).

## Nivel 1: Calentamiento
1.  **Imprimir una letra:** Modifica el código para imprimir tu inicial en pantalla.
2.  **La Suma Invisible:** Carga `5` en AX, `3` en BX, súmalos (`ADD`) y... ¿cómo sabes que ha funcionado? (Pista: Intenta imprimir el resultado sumándole `'0'` para convertirlo a ASCII, si el resultado es menor que 9).

## Nivel 2: Lógica (Saltos)
3.  **Contraseña Simple:** Haz un programa que defina un "secreto" (ej: letra 'X'). Pide una tecla al usuario. Si acierta, imprime "Y" (Yes), si falla, imprime "N" (No).
4.  **Mayúsculas:** Pide una letra minúscula ('a') y conviértela a mayúscula ('A'). Pista: En ASCII, la diferencia es restar 32 (`0x20`).

## Nivel 3: Bucles
5.  **Contador:** Imprime los números del 0 al 9 en pantalla `0123456789`.
6.  **Eco Infinito con Salida:** Haz un eco de teclado (como el driver anterior) pero que si pulsas `Enter` o `ESC`, el programa se detenga (bucle infinito `JMP $`).

## Nivel 4: Algoritmos (El Jefe Final)
7.  **Suma Interactiva:** Pide un dígito, pide otro dígito, y muestra la suma (asumiendo que suma < 10).
    *   Ejemplo: Pulso '2', Pulso '3' -> Pantalla muestra '5'.
    *   *Nota:* Recuerda que el teclado te da ASCII ('2' es valor 50), no el número 2. Tienes que convertir.
