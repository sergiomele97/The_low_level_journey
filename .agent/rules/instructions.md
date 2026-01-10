# Workspace Rules: The Low Level Journey

## 🧬 Principles
- **No Magic / Zero Abstractions:** Avoid unnecessary abstractions. Every concept (GDT, Rasm, Capas de Abstracción) must be explained and implemented manually.
- **Documentation First:** All learning, errors, and decisions must be documented in `_docs/` within each architecture folder.
- **Layers Approach:** We build our own abstractions (Assembler, OS) and document each layer as a "refined module".
- **Vibecoding:** Keep explanations simple, clear, and attractive. Focus on the *why* and the learning process.

## 📁 Structure
- `01_amd_introduction/`: Legacy studies of x86.
- `02_risc-v/`: Current path following "Zero Abstractions" philosophy.
- `*/_docs/`: Refined documentation for each module.

## ✅ Goal
Build a self-hosted Operating System for RISC-V from scratch, starting from the silicion (Capa 0).
