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
    
    # Other tools
    opencode
    pipx
  ];

  # Git configuration
  programs.git = {
    enable = true;
    userName = "George Pagarigan";
    userEmail = "georgepagarigan@example.com";  # Update with your email
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
    };
  };
}

