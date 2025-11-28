{ pkgs, ... }: {
  programs.zsh = {
    enable = true;
    
    # Shell aliases
    shellAliases = {
      ll = "ls -la";
      la = "ls -A";
      l = "ls -CF";
      grep = "grep --color=auto";
      ".." = "cd ..";
      "..." = "cd ../..";
    };
    
    # History settings
    history = {
      size = 10000;
      path = "$HOME/.config/zsh/.zsh_history";
    };
    
    # Enable completions
    enableCompletion = true;
    
    # Zsh plugins
    plugins = [
      {
        name = "zsh-autosuggestions";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-autosuggestions";
          rev = "v0.7.0";
          sha256 = "sha256-KLUYpUu4DHRumQZ3w59m9aTW6TBKMCXl2UcKi4uMd7w=";
        };
      }
      {
        name = "zsh-syntax-highlighting";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-syntax-highlighting";
          rev = "0.8.0";
          sha256 = "sha256-iJdWopZwHpSyYl5/FQXEW7gl/SrKaYDEtTH9cGP7iPo=";
        };
      }
    ];
    
    # Additional zsh configuration
    initContent = ''
      # nvm (Node Version Manager) setup
      export NVM_DIR="$HOME/.nvm"
      [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
      [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
      
      # Additional PATH entries
      export PATH="$HOME/.local/bin:$PATH"
      
      # Kubernetes completion
      if command -v kubectl &> /dev/null; then
        source <(kubectl completion zsh)
      fi
    '';
  };
}

