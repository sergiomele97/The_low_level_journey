# Project Plan & Roadmap

Este archivo rastrea nuestro progreso y tareas pendientes. Es la "memoria" del proyecto para trabajar entre diferentes máquinas.

## Roadmap
- [x] **Fase 0: Setup & "Hello World"**
    - [x] Boot sector básico (Hola Mundo).
    - [x] Ejecución en QEMU.
    - [x] Git Init & GitHub Push.
- [x] **Fase 1: Drivers Básicos (16-bit)**
    - [x] Driver de Teclado (Polling).
    - [x] Documentación modular (`docs/`).
    - [x] Assembly Playground (`03_assembly_playground`).
    - [x] BIOS Utility Library (`bios_io.asm`).
    - [x] Case Study: Interactive Sum (`docs/11_interactive_sum_case.md`).
    - [x] Case Study: Printing Strings (`docs/14_printing_strings_case.md`).
    - [x] Documentation Refactor & Deep Dives (Chapters 09-14).
- [ ] **Fase 2: Protected Mode (32-bit)**
    - [ ] Investigar GDT (Global Descriptor Table).
    - [ ] Switch a Protected Mode.
    - [ ] Driver de Pantalla VGA (Memoria 0xB8000).
- [ ] **Fase 3: Kernel en C**
    - [ ] Configurar Cross-Compiler (i686-elf-gcc).
    - [ ] Escribir el primer `main.c`.
    - [ ] Unir el Bootloader con el Kernel.
    - [ ] Vincular C con Assembly.

## Tareas Activas
- [ ] **03_assembly_playground**: Experimentar con saltos (`JNE`, `JE`) y bucles. <!-- id: playground_1 -->
- [ ] **04_protected_mode**: Investigar la teoría del cambio a 32-bits. <!-- id: prot_mode_1 -->
