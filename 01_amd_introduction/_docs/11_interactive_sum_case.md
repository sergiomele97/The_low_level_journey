# 11. Caso Práctico: Suma Interactiva
*Fecha: 5 de Enero, 2026*

Este es un ejercicio fundamental para entender cómo la CPU interactúa con el mundo exterior (humano) y cómo maneja los datos "crudos".

### El Reto
Hacer un programa que:
1. Pida un número del teclado (ej: '2').
2. Pida otro número del teclado (ej: '3').
3. Muestre el resultado de la suma (ej: '5').

### La Trampa del ASCII
Cuando pulsas '2' en el teclado, la BIOS no te da el número 2. Te da el código ASCII `50` (o `0x32`).
Si sumas `50 ('2') + 51 ('3')`, obtendrás `101`, que en ASCII es la letra **'e'**.
**¡Tu SO no puede decir que 2+3 = e!**

**Solución:** Debemos restar `'0'` (48) para obtener el valor real, sumar, y volver a sumar `'0'` para mostrarlo.

### El Código Paso a Paso

```assembly
[org 0x7c00]

    ; 1. Leer primer número
    mov ah, 0x00
    int 0x16        ; AL tiene '2' (ASCII 50)
    
    mov bl, al      ; Guardamos el primero en BL
    sub bl, '0'     ; BL = 50 - 48 = 2 (Valor real)

    ; 2. Imprimir el primero (eco)
    mov ah, 0x0e
    int 0x10

    ; 3. Leer segundo número
    mov ah, 0x00
    int 0x16        ; AL tiene '3' (ASCII 51)
    
    mov cl, al      ; Guardamos el segundo en CL
    sub cl, '0'     ; CL = 51 - 48 = 3 (Valor real)

    ; 4. Imprimir el segundo (eco)
    mov ah, 0x0e
    int 0x10

    ; 5. Sumar e imprimir el signo '='
    mov al, '='
    int 0x10

    ; 6. La Suma Real
    add bl, cl      ; BL = 2 + 3 = 5
    add bl, '0'     ; Convertimos a ASCII: 5 + 48 = 53 ('5')

    ; 7. Mostrar resultado
    mov al, bl
    int 0x10

    jmp $           ; Hang
```

### Aprendizajes Clave
1. **Registros como variables:** Hemos usado `BL` y `CL` para guardar los dos números temporalmente.
2. **Conversión de tipos:** En bajo nivel, un "número" para el humano es texto para la CPU.
3. **Persistencia:** Si no guardáramos el primer número en `BL`, al llamar a la segunda interrupción de teclado, perderíamos el valor de `AL`.
