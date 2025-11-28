{ pkgs, ... }: {
  # Linux-specific home-manager configuration
  home.username = "georgepagarigan";
  home.homeDirectory = "/home/georgepagarigan";

  # Enable home-manager
  programs.home-manager.enable = true;

  # Home Manager state version
  home.stateVersion = "24.11";

  # Allow unfree packages on Linux
  nixpkgs.config.allowUnfree = true;
  
  # Linux-specific packages
  home.packages = with pkgs; [
    ghostty  # Works on Linux, broken on Darwin
  ];
}

