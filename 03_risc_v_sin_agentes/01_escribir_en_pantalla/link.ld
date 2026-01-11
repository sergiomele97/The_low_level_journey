ENTRY(_start)

SECTIONS
{
  . = 0x80000000;         /* Dirección de inicio en QEMU */
  .text : { *(.text) }    /* Aquí va nuestro código */
}