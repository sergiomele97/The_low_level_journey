/*
 * linker.ld - Define cómo se organiza el binario final
 */

ENTRY(kmain)

SECTIONS {
    . = 0x1000;          /* El kernel se cargará en la dirección 0x1000 */

    .text : {
        *(.text)         /* El código va aquí */
    }

    .data : {
        *(.data)         /* Las variables inicializadas van aquí */
    }

    .bss : {
        *(.bss)          /* Las variables no inicializadas van aquí */
    }
}
