{ pkgs, ... }: {
  programs.zsh = {
    enable = true;
    
    # Shell aliases (migrated from zsh/.zshrc)
    shellAliases = {
      # System
      bbiu = "brew update && brew bundle install --cleanup --file=~/.config/brew/Brewfile && brew upgrade";
      cl = "clear";
      ff = "fastfetch";
      q = "exit";
      sz = "source ~/.zshrc";
      
      # Directory Navigation
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
      "-" = "cd -";
      rmd = "rm -rf";
      cdcfg = "cd ~/.config";
      
      # Editor
      nv = "nvim";
      nvh = "nvim .";
      nvhc = ''osascript -e "tell application \"Cursor\" to quit" 2>/dev/null; sleep 1; cursor . && sleep 2 && osascript -e "tell application \"Cursor\" to activate" && osascript -e "tell application \"System Events\" to keystroke \"e\" using {command down, option down}" && sleep 1 && (aerospace list-windows --all --format "%{app-name} %{window-id}" | grep -i ghostty | head -1 | awk "{print \$2}" | xargs -I {} aerospace focus --window-id {}) && aerospace resize smart +400 && nvh'';
      nvc = "nvim ~/.config";
      
      # Project Scripts
      pxd = "px dev";
      pxs = "px storybook";
      pxb = "px build";
      pxt = "px test";
      pxtw = "px test:watch";
      pxl = "px lint";
      pxlf = "px lint:fix";
      pxf = "px format";
      pxc = "px typecheck";
      
      # Package Management
      pclean = "rm -rf node_modules pnpm-lock.yaml && pi";
      pfresh = "rm -rf node_modules pnpm-lock.yaml yarn.lock package-lock.json && pi";
      pout = "px outdated";
      
      # Git
      gpo = "git pull origin --no-rebase";
      glog = "git log --graph --topo-order --pretty='%w(100,0,6)%C(yellow)%h%C(bold)%C(black)%d %C(cyan)%ar %C(green)%an%n%C(bold)%C(white)%s %N' --abbrev-commit";
      lg = "lazygit";
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
    
    # Additional zsh configuration (migrated from zsh/.zshrc)
    initContent = ''
      # ============================================================================
      # ENVIRONMENT VARIABLES
      # ============================================================================
      export TMPDIR=$(getconf DARWIN_USER_TEMP_DIR)
      export PATH="$HOME/.local/bin:$PATH"
      export OLLAMA_NUM_GPU=99
      
      # nvm (Node Version Manager) setup
      export NVM_DIR="$HOME/.nvm"
      [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
      [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
      
      # ============================================================================
      # KEY BINDINGS
      # ============================================================================
      bindkey jj vi-cmd-mode
      
      # ============================================================================
      # PROJECT CONFIGURATION
      # ============================================================================
      typeset -A projects
      projects[ui]="~/projects/ui-components-videoland"
      projects[lp]="~/projects/landing-frontend"
      projects[be]="~/projects/cc-backend-headless-cms"
      
      # ============================================================================
      # FUNCTIONS
      # ============================================================================
      
      # Auto-switch Node version if .nvmrc exists (install if missing)
      function check_nvmrc() {
        if [[ -f ".nvmrc" ]]; then
          local node_version=$(cat .nvmrc)
          if ! nvm ls "$node_version" &>/dev/null; then
            echo "📦 Node $node_version not installed. Installing..."
            nvm install "$node_version"
          else
            echo "🔄 Switching to Node $node_version"
            nvm use
          fi
        fi
      }
      
      # Navigate to project and switch Node version
      function cdp {
        local key=$1
        if [[ -z "''${projects[$key]}" ]]; then
          echo "❌ Project '$key' not found"
          return 1
        fi
        
        local expanded_path="''${projects[$key]/#\~/$HOME}"
        cd "$expanded_path"
        echo "📁 $(basename $expanded_path)"
        check_nvmrc
      }
      
      # Kill process on specific port
      function killport() {
        lsof -ti:$1 | xargs kill -9
      }
      
      # ============================================================================
      # PACKAGE MANAGEMENT (PNPM with team lockfile sync)
      # ============================================================================
      
      # Install dependencies
      function pi() {
        check_nvmrc
        
        if [[ -f "yarn.lock" ]]; then
          echo "📦 Using pnpm (syncing with yarn.lock)..."
          pnpm import 2>/dev/null || true
          echo "pnpm-lock.yaml" >> .git/info/exclude 2>/dev/null
          pnpm install --shamefully-hoist "$@"
        elif [[ -f "package-lock.json" ]]; then
          echo "📦 Using pnpm (syncing with package-lock.json)..."
          pnpm import 2>/dev/null || true
          echo "pnpm-lock.yaml" >> .git/info/exclude 2>/dev/null
          pnpm install --shamefully-hoist "$@"
        elif [[ -f "pnpm-lock.yaml" ]]; then
          echo "📦 PNPM project detected"
          pnpm install "$@"
        else
          echo "⚠️  No lockfile found. Using pnpm..."
          pnpm install "$@"
        fi
      }
      
      # Add package
      function pa() {
        check_nvmrc
        
        if [[ -f "yarn.lock" ]]; then
          echo "📦 Adding with yarn (for lockfile) + pnpm install..."
          yarn add "$@" && pnpm import 2>/dev/null && pnpm install --shamefully-hoist
        elif [[ -f "package-lock.json" ]]; then
          echo "📦 Adding with npm (for lockfile) + pnpm install..."
          npm install "$@" && pnpm import 2>/dev/null && pnpm install --shamefully-hoist
        else
          pnpm add "$@"
        fi
      }
      
      # Remove package
      function pr() {
        check_nvmrc
        
        if [[ -f "yarn.lock" ]]; then
          echo "📦 Removing with yarn (for lockfile) + pnpm install..."
          yarn remove "$@" && pnpm import 2>/dev/null && pnpm install --shamefully-hoist
        elif [[ -f "package-lock.json" ]]; then
          echo "📦 Removing with npm (for lockfile) + pnpm install..."
          npm uninstall "$@" && pnpm import 2>/dev/null && pnpm install --shamefully-hoist
        else
          pnpm remove "$@"
        fi
      }
      
      # Run pnpm command
      function px() {
        check_nvmrc
        pnpm "$@"
      }
      
      # ============================================================================
      # COMPLETIONS
      # ============================================================================
      
      # Kubernetes completion
      if command -v kubectl &> /dev/null; then
        source <(kubectl completion zsh)
      fi
      
      # ============================================================================
      # SDKMAN (Must be at the end)
      # ============================================================================
      export SDKMAN_DIR="$HOME/.sdkman"
      [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
      
      # ============================================================================
      # STARTUP
      # ============================================================================
      ff
    '';
  };
}

