# Log 07: El Cordón Umbilical (Hex-to-Bin)

*Fecha: 10 de Enero, 2026*

Para que QEMU ejecute nuestro código, necesita un archivo con **bits reales** (.bin), no un archivo de texto con letras que parecen números (.hex).

## La Herramienta de Transición
He usado un script de Python de una sola línea para hacer este puente. 

\`\`\`bash
python3 -c "import sys; data = []; f = open(sys.argv[1]); [data.extend(l.split('#')[0].split()) for l in f]; bytes_out = bytes([int(x, 16) for x in data]); open(sys.argv[2], 'wb').write(bytes_out)" origen.hex destino.bin
\`\`\`

### ¿Por qué Python?
Es la forma más rápida y transparente de transformar texto en bytes sin usar la pesada artillería de GCC (`objcopy`). Es un script que podemos leer y entender en segundos.

### ¿Cuándo lo cortaremos?
Este es nuestro "cordón umbilical". 
1. **Fase Actual**: Escribimos texto -> Python convierte a Binario -> QEMU ejecuta.
2. **Fase Nativa**: Escribimos texto -> **Nuestro Ensamblador RISC-V** convierte a Binario (en memoria) -> QEMU ejecuta.

En el momento en que nuestro código RISC-V sea capaz de leer caracteres por la UART y "escribirlos" como instrucciones en otra parte de la memoria, el script de Python morirá.

## Alternativa "Hardcore":
Si quisiéramos ser 100% puros YA, podríamos usar un **Editor Hexadecimal** (como `hexedit` o `ghex`) para escribir los bytes directamente en el archivo binario, sin pasar por archivos de texto. Pero el archivo `.hex` nos sirve de documentación humana mientras aprendemos.
