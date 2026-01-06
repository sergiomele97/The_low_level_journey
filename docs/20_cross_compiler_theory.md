# 20. El Cross-Compiler: ¿Por qué lo necesitamos?
*Fecha: 6 de Enero, 2026*

Para escribir el Kernel en C, no podemos usar simplemente el `gcc` que viene en tu Linux. Necesitamos un **Cross-Compiler**.

### 1. El problema del GCC estándar
Tu `gcc` actual está configurado para crear programas para **Linux**. Esto significa:
- Que intenta incluir librerías como `stdio.h` o `stdlib.h`.
- Que asume que hay un sistema operativo debajo que gestiona la memoria.
- Que añade cabeceras (headers) de Linux al binario final.

Nuestro Kernel **ES** el sistema operativo. No hay nada debajo. Si usamos el `gcc` normal, el código intentará hacer llamadas al sistema de Linux que no existen, y el PC explotará (o se reiniciará).

### 2. ¿Qué es un Cross-Compiler?
Es un compilador que corre en tu máquina (Linux x64) pero genera código para **otra** máquina o entorno (nuestro Bare Metal 32-bit).

El target estándar para esto es **`i686-elf`**.
- `i686`: Indica que queremos código de 32 bits (compatible con nuestro Modo Protegido).
- `elf`: Es un formato de archivo binario muy limpio y estándar que no añade "basura" de ningún sistema operativo específico.

### 3. El modo "Freestanding"
Cuando compilemos, le diremos a GCC que sea **`-ffreestanding`**. Esto es como decirle: *"Oye, no asumas que existe `printf`, ni `malloc`, ni nada. Estás solo. Buena suerte"*.

En este modo, solo tenemos acceso a lo que nosotros mismos escribamos. Es el modo de purismo máximo.

---

**Siguiente paso:** Vamos a intentar compilar nuestro primer archivo `.c` y ver cómo el compilador protesta porque no encuentra "nada".
