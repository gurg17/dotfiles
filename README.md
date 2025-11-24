# Dotfiles

Personal configuration files for macOS development environment.

## 📁 Structure

```
~/.config/
├── aerospace/         # Window manager (tiling)
├── brew/             # Homebrew packages (Brewfile)
├── btop/             # System monitor
├── fastfetch/        # System info display
├── ghostty/          # Terminal emulator + themes
├── nushell/          # Modern shell
├── nvim/             # Neovim editor (see nvim/README.md)
├── opencode/         # OpenCode config
├── raycast/          # Raycast launcher
├── sketchybar/       # macOS status bar
├── starship/         # Shell prompt
└── zsh/              # Z shell
```

## 🚀 Quick Start

### 1. Clone Repository
```bash
git clone <repository-url> ~/.config
cd ~/.config
```

### 2. Install Packages
```bash
brew bundle --file=brew/Brewfile
```

### 3. Configure Tools
Most tools automatically detect configs in `~/.config/`. See individual folder READMEs for details.

## 🔧 Tools

| Tool | Purpose | Config Location | Docs |
|------|---------|----------------|------|
| **Neovim** | Code editor (TypeScript/JS focus) | `nvim/` | [README](nvim/README.md) |
| **AeroSpace** | Window tiling manager | `aerospace/aerospace.toml` | - |
| **Ghostty** | Terminal emulator | `ghostty/config` | - |
| **SketchyBar** | Status bar | `sketchybar/sketchybarrc` | - |
| **Nushell** | Modern shell | `nushell/config.nu` | - |
| **Starship** | Shell prompt | `starship/starship.toml` | - |
| **Homebrew** | Package manager | `brew/Brewfile` | - |

## 📖 Detailed Documentation

Each major tool has its own README with detailed configuration, keymaps, and usage:

- **[Neovim](nvim/README.md)** - Complete LSP setup, keymaps, plugins, and how to extend

## 🔄 Maintenance

### Update Packages
```bash
brew update && brew upgrade
brew bundle dump --force --file=brew/Brewfile
```

### Reload Configs
```bash
# Neovim: Restart or :Lazy sync
# SketchyBar: sketchybar --reload
# AeroSpace: aerospace --reload-config
```

## 💡 Philosophy

- **Minimal**: Only essential tools and plugins
- **Fast**: Performance-first configurations
- **Documented**: Each tool explained (see individual READMEs)
- **Reproducible**: Declarative configs (Brewfile, lazy-lock.json, etc.)

## 📝 Notes

- **macOS-specific**: Tested on macOS 14.5+ (Sonoma)
- **~/.config standard**: XDG Base Directory compliant
- **Git-tracked**: All configs versioned for easy restoration

---

**For detailed tool-specific documentation, see the README in each folder (e.g., `nvim/README.md`)** 