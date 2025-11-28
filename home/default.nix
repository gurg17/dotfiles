{ pkgs, ... }: {
  # Import all home modules
  imports = [
    ./packages.nix
    ./zsh.nix
    ./starship.nix
  ];

  # Home Manager settings
  programs.home-manager.enable = true;
  home.stateVersion = "24.11";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
}

