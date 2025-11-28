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
      # "sketchybar"  # macOS status bar - disabled for macOS 26 beta (already installed)
    ];
    
    # GUI applications (casks)
    casks = [
      # Editors
      "cursor"
      
      # Productivity
      "obsidian"
      
      # Fonts (Apple-specific)
      "font-sf-pro"
      "sf-symbols"
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

