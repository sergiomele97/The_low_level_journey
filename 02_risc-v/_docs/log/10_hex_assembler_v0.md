# Log 10: El Primer Ensamblador Nativo (v0)

*Fecha: 10 de Enero, 2026*

Hoy nace el primer programa RISC-V que puede **crear otros programas**. Es el momento más importante del proyecto hasta ahora.

## El Desafío del Huevo y la Gallina

Para tener un ensamblador necesitamos... un ensamblador. ¿Cómo salimos de este círculo?

**Solución**: Escribir el primer ensamblador directamente en hexadecimal. Será un programa de ~200-300 bytes que permitirá escribir el siguiente ensamblador más cómodo.

## Arquitectura del v0

### Mapa de Memoria
```
0x80000000  ← Código del Assembler v0 (aquí estamos nosotros)
0x80000200  ← Buffer de Usuario (aquí escribimos el código recibido)
0x80001000  ← Stack (crece hacia abajo)
```

### Flujo de Ejecución
1. Imprimir prompt `> `
2. Leer bytes hexadecimales por UART
3. Convertir ASCII → Bytes binarios
4. Escribir en buffer (0x80000200)
5. Al pulsar Enter → Saltar y ejecutar

## Funciones Implementadas

### 1. `uart_getchar`
Lee un carácter de la UART usando polling (reutilizamos la lógica del echo).

### 2. `uart_putchar`
Escribe un carácter a la UART.

### 3. `hex_to_nibble`
Convierte un carácter ASCII ('0'-'9', 'A'-'F', 'a'-'f') a su valor numérico (0-15).

**Algoritmo**:
- Si está entre '0' y '9' → valor - '0'
- Si está entre 'A' y 'F' → valor - 'A' + 10
- Si está entre 'a' y 'f' → valor - 'a' + 10
- Cualquier otra cosa → -1 (inválido)

### 4. `read_hex_byte`
Lee dos caracteres hex consecutivos y los combina en un byte.
- Primer carácter → nibble alto (shift left 4)
- Segundo carácter → nibble bajo
- Combinar con OR

### 5. Loop Principal
- Espera caracteres por UART
- Si es espacio → ignora
- Si es newline/enter → ejecuta código en buffer
- Si es dígito hex → lee otro, combina, escribe en memoria

## Limitaciones Conocidas (Aceptables para v0)

> [!WARNING]
> Este v0 es **intencionalmente minimalista**:
> - ❌ Sin etiquetas ni símbolos
> - ❌ Sin mnemonics (solo hex crudo)
> - ❌ Sin manejo de errores robusto
> - ❌ Sin "return" al assembler (código usuario debe auto-gestionar)
>
> Estas limitaciones desaparecerán en v1, que escribiremos **usando** v0.

## El Momento de la Verdad

Cuando este programa funcione, habremos alcanzado el primer nivel de **self-hosting**: código RISC-V que procesa y ejecuta otro código RISC-V, sin ayuda de Python o GCC para la transformación.

El "cordón umbilical" de Python solo se usará una última vez: para convertir el propio v0 de hex a binario. Después de eso, v0 puede procesar todo lo demás.

---

*Próximo Log: Pruebas y debugging del v0*
