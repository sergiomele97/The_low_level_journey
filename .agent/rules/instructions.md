# Workspace Rules: The Low Level Journey (RISC-V Edition)

## 🧬 Principles
- **No Magic / Pureza Absoluta:** No external tools (No GCC, No Python for output). Everything built from Capa 0.
- **Dual Documentation:**
    - `_docs/capas/`: Technical, synthesized specs of each layer.
    - `_docs/log/`: Numbered chronological learning journey (mistakes, solutions).
- **Structure Partition:**
    - `core/`: Refined "final" code for each layer.
    - `lab/`: Experimental area for testing and manual injections.

## 📁 Structure
- `01_amd_introduction/`: Legacy x86 material.
- `02_risc-v/`: Current project path.
    - `02_risc-v/_docs/`: Documentation (Log & Capas).
    - `02_risc-v/core/`: Production code.
    - `02_risc-v/lab/`: Experimental code.

## ✅ Goal
Build a self-hosted OS for RISC-V from absolute zero (Silicon manual).
