#Tamaños RISC-V (x64)

    Registro => 8 bytes
    Instruccion => 4 bytes => El procesador lee de 32 en 32 bits, en ellos están incluidos los parámetros que pasas a las instrucciones.
    Dirección ram (puntero) => 8 bytes
    Unidad de ram (contenido de la posición que indica el puntero) => 1 byte
    Carácter => 1 byte

#Sintáxis as

    0(a0) => Recuperar contenido de dirección de memoria a0
    5(a0) => Recupera el contenido de la posición a0 + 5

    .macro NOMBRE_MACRO parámetro => Definir macro
    .endm => Fin macro

    etiqueta1: => Definir una etiqueta

#Instrucciones RISC-V

    li => Load inmediate (dirección memoria, número a cargar)
    lbu => Load byte unsigned (dirección memoria, byte a cargar)
    andi => And inmediate (dirección memoria donde guardar resultado, byte a comparar 1, byte a comparar 2)
    beqz => Branch if equal zero (direccion a comparar, dirección a donde saltar)
    sb => Store byte (byte a guardar, dónde guardarlo)
    addi => Add inmediate  (dónde guardar resultado, sumando1, sumando2)
    j => jump (Etiqueta a dónde)

#Casos concretos de uso

    Aislar un bit => andi
    Encender un bit => ori
    Invertir un bit => xori