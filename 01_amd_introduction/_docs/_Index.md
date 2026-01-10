# Index: The Low Level Journey

## Fase 0: El Despegue
- [00. Herramientas](00_herramientas.md) (QEMU, NASM y GCC)
- [01. El Boot Sector](01_boot_sector.md) (Hola Mundo desde el Metal)
- [02. Arquitecturas](02_arquitecturas.md) (x86, ARM y RISC-V)

## Fase 1: Inmersión en 16 bits
- [03. El Proceso de Compilación](03_compilacion.md) (Binarios y Hex)
- [04. Símbolos y Debugging](04_simbolos.md) (Etiquetas y Memoria)
- [05. CPU Internals](05_cpu_internals.md) (Decoding y Microcode)
- [06. x86 Legacy](06_x86_legacy.md) (Deuda Técnica y Registro)
- [07. Driver de Teclado](07_keyboard.md) (Interrupciones y Polling)
- [09. Ensamblador Básico](09_assembly_basics.md) (Registros y Stack)
- [10. Punteros y Memoria](10_pointers_memory.md) (Direccionamiento)
- [11. Caso Práctico: Suma Interactiva](11_interactive_sum_case.md) (Input y ASCII)
- [14. Caso Práctico: Imprimir Strings](14_printing_strings_case.md) (Loops y Punteros)
- [15. Números > 9 y División](15_multi_digit_output.md) (Sistemas de Numeración)

## Fase 2: El Salto a los 32 bits
- [16. Protected Mode: La Teoría](16_protected_mode_theory.md) (Adiós a los 16 bits)
- [18. El Ritual: BIOS vs UEFI](18_uefi_vs_bios_ritual.md) (¿Por qué hacemos esto?)
- [19. Destripando los 32 bits](19_protected_mode_code_breakdown.md) (Paso a Paso)

## Fase 3: El Kernel en C
- [20. El Cross-Compiler](20_cross_compiler_theory.md) (La Barrera de C)
- [21. Linker Scripts y Entry Points](21_linker_scripts.md) (Paso a C)
- [22. GDT Deep Dive](22_gdt_deep_dive.md) (El Segurata de 32 bits)
- [23. El Pipeline de Compilación](23_compilation_pipeline.md) (Puzzles y Objetos)
- [24. Makefile Automation](24_makefile_automation.md) (El Robot de Cocina)

---
### Meta
- [08. Estandarización & Git](08_git.md) (Cómo nos organizamos)
- [17. Estrategias Modernas](17_modern_os_strategies.md) (UEFI, Rust y Futuro)
