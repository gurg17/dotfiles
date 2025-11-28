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
    # Note: brave, firefox-dev, raycast, aerospace are managed by Nix
    # and appear in /Applications/Home Manager Apps/
    casks = [
      # Terminals
      "ghostty"
      
      # Editors
      "cursor"
      
      # Fonts (Apple-specific)
      "font-sf-pro"
      "sf-symbols"
      
      # Keyboard layouts
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

