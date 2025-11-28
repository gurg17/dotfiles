# Dotfiles

Cross-platform configuration files for macOS and Linux development environment, managed with Nix.

## 📁 Structure

```
~/.config/
├── flake.nix           # Main Nix flake configuration
├── flake.lock          # Lock file for reproducible builds
├── hosts/              # Host-specific configurations
│   ├── darwin/         # macOS (nix-darwin)
│   └── linux/          # Linux (home-manager)
├── home/               # Home-manager modules
│   ├── default.nix     # Main home config
│   ├── packages.nix    # Cross-platform packages
│   ├── zsh.nix         # Zsh configuration
│   └── starship.nix    # Starship prompt
├── modules/            # Additional modules
│   └── darwin/         # macOS-specific modules
│       └── homebrew.nix # Homebrew packages
├── scripts/            # Setup scripts
│   └── setup-ollama.sh # Ollama model setup
├── brew/               # Fallback Brewfile
├── aerospace/          # Window manager
├── btop/               # System monitor
├── fastfetch/          # System info
├── ghostty/            # Terminal emulator + themes
├── nvim/               # Neovim editor (see nvim/README.md)
├── opencode/           # OpenCode config
├── raycast/            # Raycast launcher
├── sketchybar/         # macOS status bar
├── starship/           # Legacy starship config (kept for reference)
└── zsh/                # Legacy zsh config (kept for reference)
```

## 🚀 Quick Start

### Prerequisites

**macOS:**
- Install Nix: `sh <(curl -L https://nixos.org/nix/install)`
- Install nix-darwin: Follow [official docs](https://github.com/LnL7/nix-darwin)

**Linux:**
- Install Nix: `sh <(curl -L https://nixos.org/nix/install) --daemon`
- Install home-manager: Follow [official docs](https://github.com/nix-community/home-manager)

### Setup

#### 1. Clone Repository
```bash
git clone <repository-url> ~/.config
cd ~/.config
```

#### 2. Apply Configuration

**macOS (nix-darwin):**
```bash
# First time setup
darwin-rebuild switch --flake .#io

# For other machines, update flake.nix with your hostname:
# darwin-rebuild switch --flake .#<your-hostname>
```

**Linux (home-manager):**
```bash
# First time setup
home-manager switch --flake .#georgepagarigan@linux

# For other users/machines, update flake.nix
```

#### 3. Setup Ollama Models (Optional)
```bash
./scripts/setup-ollama.sh
```

This will pull:
- `qwen2.5-coder:1.5b` - Fast coding assistant
- `deepseek-r1:14b` - Reasoning model

## 🔧 Tools

| Tool | Purpose | Managed By |
|------|---------|------------|
| **Neovim** | Code editor (TypeScript/JS focus) | Nix + raw configs |
| **Zsh** | Shell | home-manager |
| **Starship** | Prompt | home-manager |
| **Ghostty** | Terminal emulator | Homebrew (macOS) / raw config |
| **AeroSpace** | Window tiling manager | Homebrew (macOS only) |
| **SketchyBar** | Status bar | Homebrew (macOS only) |
| **Ollama** | Local LLM runner | Nix |

## 📦 Package Management

### Nix (Cross-platform)
Primary package manager for CLI tools and development environments.

**Update packages:**
```bash
# macOS
darwin-rebuild switch --flake .

# Linux  
home-manager switch --flake .
```

### Homebrew (macOS Fallback)
Used for GUI applications, fonts, and macOS-specific tools.

**Manual Brewfile (non-Nix machines):**
```bash
brew bundle --file=brew/Brewfile
```

## 🔄 Adding New Machines

### macOS
Edit `flake.nix` and add a new configuration:

```nix
darwinConfigurations."new-mac" = nix-darwin.lib.darwinSystem (mkSystem {
  system = "aarch64-darwin";  # or "x86_64-darwin" for Intel
  hostname = "new-mac";
  username = "yourusername";
});
```

Then run:
```bash
darwin-rebuild switch --flake .#new-mac
```

### Linux
Edit `flake.nix` and add:

```nix
homeConfigurations."username@new-linux" = home-manager.lib.homeManagerConfiguration {
  pkgs = nixpkgs.legacyPackages.x86_64-linux;  # or aarch64-linux
  modules = [
    ./hosts/linux
    ./home
  ];
};
```

Then run:
```bash
home-manager switch --flake .#username@new-linux
```

## 🎨 Customization

### Adding Packages
Edit `home/packages.nix` to add cross-platform CLI tools.

### Zsh Configuration
Edit `home/zsh.nix` for shell aliases, plugins, and initialization.

### Starship Prompt
Edit `home/starship.nix` to customize the prompt theme.

### macOS GUI Apps
Edit `modules/darwin/homebrew.nix` to add/remove Homebrew casks.

## 🔄 Maintenance

### Update Nix Flake Inputs
```bash
nix flake update
```

### Update Brewfile (for non-Nix machines)
```bash
brew bundle dump --force --file=brew/Brewfile
```

### Reload Configs
```bash
# Neovim: Restart or :Lazy sync
# SketchyBar: sketchybar --reload
# AeroSpace: aerospace --reload-config
```

## 💡 Philosophy

- **Cross-platform**: Works on macOS and Linux with minimal changes
- **Declarative**: Nix manages packages and configuration reproducibly
- **Hybrid approach**: Nix for packages, raw configs for complex setups (nvim)
- **Fallback support**: Brew still available for machines without Nix
- **Fast**: Performance-first configurations
- **Documented**: Clear structure and setup instructions

## 📖 Detailed Documentation

Each major tool has its own README or config:

- **[Neovim](nvim/README.md)** - Complete LSP setup, keymaps, plugins

## 📝 Notes

- **macOS support**: Tested on Apple Silicon (M1/M2/M4) and Intel Macs
- **Linux support**: Works on x86_64 and aarch64 architectures
- **XDG Base Directory**: Follows `~/.config` standard
- **Git-tracked**: All configs versioned for easy restoration
- **Nix flakes**: Requires experimental features enabled

## 🤝 Contributing

This is a personal dotfiles repository, but feel free to:
- Fork and adapt for your own use
- Open issues for bugs or questions
- Submit PRs for improvements

---

**For detailed tool-specific documentation, see the README in each folder (e.g., `nvim/README.md`)**
