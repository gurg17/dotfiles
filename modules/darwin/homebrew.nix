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
      # Note: sketchybar is manually managed outside nix-darwin
      # (Cannot compile on macOS 26 beta due to outdated Xcode CLT)
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
      
      # Keyboard layouts
      "colemak-dh"  # Linux-only in nixpkgs
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

