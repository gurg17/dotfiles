{ lib, ... }: {
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
}

