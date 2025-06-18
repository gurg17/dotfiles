# Dotfiles

Personal configuration files for macOS development environment.

## Overview

This repository contains configuration files for various development tools and applications used in my daily workflow. The configurations are optimized for macOS and focus on productivity, aesthetics, and functionality.

## Tools & Configurations

### 🪟 [AeroSpace](aerospace/)
Window management configuration for AeroSpace, a tiling window manager for macOS.
- **File**: `aerospace.toml`
- **Purpose**: Automated window tiling and workspace management

### 🍺 [Homebrew](brew/)
Package management configuration for Homebrew.
- **File**: `Brewfile`
- **Purpose**: Declarative package installation and management
- **Usage**: Run `brew bundle` to install all packages

### 👻 [Ghostty](ghostty/)
Terminal emulator configuration with custom themes.
- **Files**: `config`, `themes/`
- **Features**: 
  - Custom configuration settings
  - Multiple Noctis theme variants (azureus, bordo, hibernus, lilac, lux, minimus, uva, viola)

### 🐚 [Nushell](nushell/)
Modern shell configuration with structured data support.
- **Files**: `config.nu`, `env.nu`, `history.txt`
- **Features**: Structured shell with powerful data manipulation capabilities

### 📊 [SketchyBar](sketchybar/)
Highly customizable status bar for macOS.
- **Files**: `sketchybarrc`, `plugins/`
- **Plugins**:
  - `battery.sh` - Battery status indicator
  - `clock.sh` - Date and time display
  - `front_app.sh` - Current application indicator
  - `space.sh` - Workspace/space indicator
  - `volume.sh` - Audio volume control

### ⭐ [Starship](starship/)
Cross-shell prompt configuration.
- **File**: `starship.toml`
- **Purpose**: Fast, customizable shell prompt with git integration

### 🔧 [Zsh](zsh/)
Z shell configuration and customizations.
- **Purpose**: Shell environment setup and customizations

## Installation

### Prerequisites
- macOS (tested on macOS Sonoma 14.5+)
- Homebrew installed
- Git

### Quick Setup

1. **Clone the repository**:
   ```bash
   git clone <repository-url> ~/.config
   cd ~/.config
   ```

2. **Install packages**:
   ```bash
   brew bundle --file=brew/Brewfile
   ```

3. **Symlink configurations** (if needed):
   ```bash
   # Most tools will automatically detect configs in ~/.config/
   # Manual symlinking may be required for some tools
   ```

### Individual Tool Setup

#### AeroSpace
```bash
# AeroSpace will automatically load config from ~/.config/aerospace/
aerospace --reload-config
```

#### Ghostty
```bash
# Ghostty automatically loads from ~/.config/ghostty/
# Restart Ghostty to apply changes
```

#### Nushell
```bash
# Configs are automatically loaded from ~/.config/nushell/
# Restart your shell or run:
source ~/.config/nushell/config.nu
```

#### SketchyBar
```bash
# Start SketchyBar service
brew services start sketchybar
# Or reload configuration
sketchybar --reload
```

#### Starship
```bash
# Add to your shell profile:
eval "$(starship init zsh)"  # for zsh
eval "$(starship init bash)" # for bash
```

## Customization

### Themes
The Ghostty configuration includes multiple Noctis theme variants. To switch themes, modify the `theme` setting in `ghostty/config`.

### SketchyBar Plugins
Each plugin in `sketchybar/plugins/` can be customized independently. Modify the scripts to change appearance or functionality.

### Starship Prompt
Edit `starship/starship.toml` to customize the shell prompt appearance and modules.

## Maintenance

### Updating Packages
```bash
# Update Homebrew packages
brew update && brew upgrade

# Update Brewfile
brew bundle dump --force --file=brew/Brewfile
```

### Backup
This repository serves as a backup of your configurations. Regular commits ensure your settings are preserved.

## Requirements

- macOS 12.0+ (recommended)
- Homebrew
- Git

## License

Personal dotfiles - use at your own discretion.

---

**Note**: These configurations are tailored for personal use. You may need to adjust paths, preferences, or remove specific configurations that don't match your setup. 