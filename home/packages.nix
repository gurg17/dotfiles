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
    
    # Fonts
    nerd-fonts.hack
    nerd-fonts.jetbrains-mono
    
    # Other tools
    opencode
    pipx
  ];

  # Git configuration
  programs.git = {
    enable = true;
    settings = {
      user.name = "George Luis Pagarigan";
      user.email = "george.luis.pagarigan@gmail.com";  # Update with your email
      init.defaultBranch = "main";
      pull.rebase = true;
    };
  };
}

