{
  description = "George's nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
  };


  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew }:
  let
    configuration = { pkgs, ... }: {
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages =
        [ 
	  pkgs.neovim
	  pkgs.xcodes
	  pkgs.git
        ];
      
      homebrew = {
      	enable = true;
	brews = [ 
	  "mas"
	];
	casks = [
	  "ghostty"
	  "zen"
	];
	masApps = {
	  #"Yoink" = 457622435;
	};
	onActivation.cleanup = "zap";
	onActivation.autoUpdate = true;
	onActivation.upgrade = true;
      };

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Enable alternative shell support in nix-darwin.
      # programs.fish.enable = true;
      # programs.nushell.enable = true;

      # user.defaultUserShell = pkgs.nushell;

      system.primaryUser = "georgepagarigan";      
      system.defaults = {
	dock.autohide = true;
      }
      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 6;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#simple
    darwinConfigurations."io" = nix-darwin.lib.darwinSystem {
      modules = [ 
      	configuration
	nix-homebrew.darwinModules.nix-homebrew
	{
		nix-homebrew = {
			enable = true;
			enableRosetta= true;
			user = "georgepagarigan";
			autoMigrate = true;
		};
	}
      ];
      
    };
  };
}
