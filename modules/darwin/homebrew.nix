{ ... }: {
  homebrew = {
    enable = true;
    
    # Taps
    taps = [
      "FelixKratz/formulae"
    ];
    
    # CLI tools that are better via homebrew on macOS
    brews = [
      "mas"  # Mac App Store CLI
      "sketchybar"  # macOS status bar
    ];
    
    # GUI applications (casks)
    casks = [
      # Terminals & Editors
      "ghostty"
      "cursor"
      
      # Browsers
      "brave-browser"
      "firefox@developer-edition"
      "zen"
      
      # Productivity
      "raycast"
      "obsidian"
      
      # Development
      "beekeeper-studio"
      
      # Window Management
      "aerospace"
      
      # Fonts
      "font-hack-nerd-font"
      "font-jetbrains-mono-nerd-font"
      "font-sf-pro"
      "sf-symbols"
      
      # Keyboard
      "colemak-dh"
    ];
    
    # Mac App Store apps
    masApps = {
      # Add your Mac App Store apps here
      # Example: "Yoink" = 457622435;
    };
    
    # Cleanup on activation
    onActivation = {
      cleanup = "zap";
      autoUpdate = true;
      upgrade = true;
    };
  };
}

