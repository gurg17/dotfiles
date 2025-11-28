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
      # Terminals
      "ghostty"  # Broken in nixpkgs on Darwin, use Homebrew instead
      
      # Editors
      "cursor"
      
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

