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
  darwin = lib.mkIf pkgs.stdenv.isDarwin {
    installApps = true;  # Symlink to /Applications/Nix Apps/
    fullCopies = true;   # Create full copies instead of symlinks for better integration
  };
}

