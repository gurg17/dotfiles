{
  description = "Cross-platform dotfiles with nix-darwin and home-manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    
    # macOS system management
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    
    # Homebrew management for macOS
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    
    # Home-manager for user environment
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nixpkgs, nix-darwin, nix-homebrew, home-manager }:
  let
    # Helper function to create system configurations
    mkSystem = { system, hostname ? null, username }: {
      inherit system;
      modules = [
        ./hosts/darwin
        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            enable = true;
            enableRosetta = true;
            user = username;
            autoMigrate = true;
          };
        }
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.${username} = import ./home;
          
          # Set user info explicitly for home-manager
          users.users.${username}.home = "/Users/${username}";
          
          system.primaryUser = username;
        }
        # Only set hostname if explicitly provided
        # If null, nix-darwin will keep the system's current hostname
        (if hostname != null then {
          networking.hostName = hostname;
        } else {})
      ];
    };
  in
  {
    # macOS configurations (nix-darwin)
    darwinConfigurations = {
      # darwin-rebuild switch --flake .#darwin
      "darwin" = nix-darwin.lib.darwinSystem (mkSystem {
        system = "aarch64-darwin";
        hostname = "VNJ1X7772W-George";  # Temporarily set - will be null after rebuild
        username = "georgepagarigan";
      });
      
      # Template for other macOS machines
      # "other-mac" = nix-darwin.lib.darwinSystem (mkSystem {
      #   system = "aarch64-darwin";  # or "x86_64-darwin" for Intel
      #   hostname = "other-mac";
      #   username = "yourusername";
      # });
    };

    # Linux configurations (standalone home-manager)
    homeConfigurations = {
      # Example: home-manager switch --flake .#georgepagarigan@linux
      "georgepagarigan@linux" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        modules = [
          ./hosts/linux
          ./home
        ];
      };
      
      # Template for ARM Linux
      # "username@linux-arm" = home-manager.lib.homeManagerConfiguration {
      #   pkgs = nixpkgs.legacyPackages.aarch64-linux;
      #   modules = [
      #     ./hosts/linux
      #     ./home
      #   ];
      # };
    };
  };
}

