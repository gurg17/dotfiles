{ lib, pkgs, ... }: {
  # Import all home modules
  imports = [
    ./packages.nix
    ./zsh.nix
    ./starship.nix
  ];

  # Home Manager settings
  programs.home-manager.enable = true;
  home.stateVersion = "24.11";

  # These will be set by the darwin configuration
  home.username = lib.mkDefault "georgepagarigan";
  home.homeDirectory = lib.mkDefault "/Users/georgepagarigan";
  
  # Disable version check warning
  home.enableNixpkgsReleaseCheck = false;

  # macOS-specific: Enable GUI app installation
  targets.darwin = lib.mkIf pkgs.stdenv.isDarwin {
    defaults = {};  # Enable darwin target
  };
  
  # Install apps to /Applications/Nix Apps/
  home.activation = lib.mkIf pkgs.stdenv.isDarwin {
    copyApplications = lib.hm.dag.entryAfter ["writeBoundary"] ''
      echo "Installing applications..."
      appsSrc="$HOME/.nix-profile/Applications"
      if [ -d "$appsSrc" ]; then
        baseDir="/Applications/Nix Apps"
        sudo mkdir -p "$baseDir"
        sudo chown $USER: "$baseDir"
        for app in "$appsSrc"/*.app; do
          if [ -e "$app" ]; then
            appName=$(basename "$app")
            echo "Copying $appName"
            sudo rm -rf "$baseDir/$appName"
            sudo cp -rL "$app" "$baseDir/$appName"
          fi
        done
      fi
    '';
  };
}

