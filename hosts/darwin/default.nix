{ pkgs, ... }: {
  # Nix configuration
  nix.settings.experimental-features = "nix-command flakes";

  # System packages (minimal - most managed by home-manager)
  environment.systemPackages = with pkgs; [
    git
  ];

  # Import homebrew configuration
  imports = [
    ../../modules/darwin/homebrew.nix
  ];

  # macOS system defaults
  system.defaults = {
    dock.autohide = true;
  };

  # Set Git commit hash for darwin-version
  system.configurationRevision = null;

  # Used for backwards compatibility
  # $ darwin-rebuild changelog
  system.stateVersion = 6;

  # Platform
  nixpkgs.hostPlatform = "aarch64-darwin";
  
  # Allow unfree packages globally
  nixpkgs.config.allowUnfree = true;
}

