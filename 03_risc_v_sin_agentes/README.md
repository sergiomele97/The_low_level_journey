Pues a ver esto de los agentes y apis gratuitas esta muy capado.

Voy a evitar depender de ellos, entonces hay que definir nuevos objetivos realistas en mi contexto actual.

Quiero partir del set de instrucciones de risc-v, probablemente empezar en 32 bits e intentar construir desde ahí. Acepto utilizar un ensamblador como nasm o el que toque, pero quiero no usar lenguajes de programación ni más abstracciones que no haya hecho yo.

---
para correr: make run
para salir: ctrl + a => x
---
para debug: make debug (en una terminal)

gdb-multiarch kernel.elf -ex "target remote :1234" -ex "layout asm" -ex "layout regs" -ex "break _start" -ex "continue" (en otra terminal y escribir "si" y pulsar enter)

para salir: q => enter
---