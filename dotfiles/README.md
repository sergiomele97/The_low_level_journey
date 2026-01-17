# 🚀 Sergio's Dotfiles

Un entorno de desarrollo minimalista y ultrapotente basado en **Tmux + Neovim (LazyVim) + Yazi**. Configura tu Ubuntu en segundos.

## ⚡ Instalación Instantánea

Solo copia, pega y deja que ocurra la magia:

```bash
git clone https://github.com/sergiomele97/dotfiles.git ~/work/dotfiles && cd ~/work/dotfiles && ./install.sh
```

---

<details>
<summary>🛠️ <b>¿Qué hay bajo el capó? (Specs & Features)</b></summary>

### 💻 Editor: Neovim (LazyVim)
- **LazyVim Integration**: Estructura modular y rápida.
- **Multilenguaje**: Soporte nativo (LSP/Format) para `Python`, `Rust`, `C`, `Markdown` y `Assembly`.
- **UI Moderna**: `Tokyonight` theme y `Treesitter` para resaltado perfecto.

### 🪟 Terminal: Tmux + TPM
- **Gestor de Sesiones**: Configuración personalizada con prefix `C-a`.
- **Plugins**: Incluye `tmux-sensible` y gestor de plugins `TPM`.
- **Quick-Cheatsheets**: Acceso instantáneo a chuletas de QEMU y Tmux.

### 📂 File Manager: Yazi
- **Extremadamente rápido**: Escrito en Rust.
- **Preview de todo**: Soporte para imágenes, PDF (via poppler) y archivos comprimidos.

### 🔧 CLI Power Tools
- `fzf`: Buscador difuso increíble.
- `ripgrep`: Búsqueda de texto a la velocidad del rayo.
- `zoxide`: Un comando `cd` inteligente que aprende de tus carpetas.
- `fd`: Alternativa moderna a `find`.
</details>

## ⌨️ Comandos clave
- `tm`: Inicia tu flujo de trabajo (3 ventanas: Principal + Dev + RISC-V).
- `y`: Abre Yazi (salta al directorio actual al cerrarlo).
- `dot`: Salto rápido a tu carpeta de dotfiles.
- `source ~/.bashrc`: Refresca tu configuración.

---
🚀 *Desarrollado para la máxima eficiencia.*
