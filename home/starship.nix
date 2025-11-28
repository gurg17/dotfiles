{ ... }: {
  programs.starship = {
    enable = true;
    
    settings = {
      add_newline = false;
      command_timeout = 1000;
      
      format = "$directory$git_branch$git_status\n$character";
      right_format = "$nodejs$docker_context$kubernetes$gcloud$golang$cmd_duration";
      
      # Kanagawa-themed prompt
      character = {
        success_symbol = "[❯](bold #98BB6C)";
        error_symbol = "[❯](bold #E82424)";
        vicmd_symbol = "[❮](bold #FF9E3B)";
      };
      
      directory = {
        truncation_length = 3;
        truncate_to_repo = true;
        style = "bold #7E9CD8";
        read_only = "[ 󰌾 ](#E46876)";
      };
      
      git_branch = {
        format = "[ ](bold #957FB8)[$branch]($style)";
        style = "#DCD7BA";
      };
      
      git_status = {
        format = "[$all_status$ahead_behind]($style)";
        style = "#DCD7BA";
        conflicted = "[ ](bold #E82424)";
        ahead = "[ ⇡ ](bold #98BB6C)\${count}";
        behind = "[ ⇣ ](bold #FFA066)\${count}";
        diverged = "[ ⇕ ](bold #FF9E3B)⇡\${ahead_count} ⇣\${behind_count}";
        untracked = "[  ](bold #7AA89F)\${count}";
        stashed = "[ 󰏗 ](bold #957FB8)";
        modified = "[  ](bold #DCA561)\${count}";
        staged = "[ 󰐗 ](bold #76946A)\${count}";
        deleted = "[ 󰍴 ](bold #C34043)\${count}";
      };
      
      nodejs = {
        format = "[  ](bold #98BB6C)[$version](#DCD7BA)";
        detect_files = ["package.json" ".nvmrc"];
        detect_folders = ["node_modules"];
      };
      
      docker_context = {
        format = "[ 󰡨 ](bold #7FB4CA)[$context](#DCD7BA)";
      };
      
      kubernetes = {
        format = "[ 󱃾 ](bold #7FB4CA)[$context( \\($namespace\\))]($style)";
        style = "#DCD7BA";
        disabled = false;
      };
      
      gcloud = {
        format = "[ 󱇶 ](bold #7E9CD8)[$account(@$domain)(\\($region\\))]($style)";
        style = "#DCD7BA";
      };
      
      golang = {
        format = "[  ](bold #7AA89F)[$version](#DCD7BA)";
      };
      
      helm = {
        format = "[ 󱃾 ](bold #7FB4CA)[$version](#DCD7BA)";
      };
      
      cmd_duration = {
        min_time = 2000;
        format = "[  ](bold #FF9E3B)[$duration](#DCD7BA)";
        show_notifications = false;
      };
      
      # Disabled modules
      aws.disabled = true;
      terraform.disabled = true;
      vagrant.disabled = true;
      java.disabled = true;
      ruby.disabled = true;
      rust.disabled = true;
      python.disabled = true;
      php.disabled = true;
    };
  };
}

