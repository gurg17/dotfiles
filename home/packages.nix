{ pkgs, ... }: {
  home.packages = with pkgs; [
    # Core utilities
    git
    ripgrep
    shfmt
    
    # Development tools
    neovim
    lazygit
    
    # System monitoring
    btop
    fastfetch
    
    # Node.js ecosystem
    nodejs
    pnpm
    
    # Cloud & DevOps
    azure-cli
    kubectl
    
    # AI & LLM
    ollama
    
    # GUI Applications (macOS)
    ghostty
    raycast
    aerospace
    brave
    firefox-devedition
    
    # Fonts
    nerd-fonts.hack
    nerd-fonts.jetbrains-mono
    
    # Keyboard layouts
    colemak-dh
    
    # Other tools
    opencode
    pipx
  ];

  # Git configuration
  programs.git = {
    enable = true;
    settings = {
      user.name = "George Pagarigan";
      user.email = "georgepagarigan@example.com";  # Update with your email
      init.defaultBranch = "main";
      pull.rebase = true;
    };
  };
}

