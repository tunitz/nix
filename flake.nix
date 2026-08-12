/**
  Master Flake Configuration

  WARNING: CORE INFRASTRUCTURE FILE. Do not casually modify the logic in this file. 
  This file acts as the central orchestrator for the entire NixOS setup. It dynamically reads the directory structure to generate machine configurations.
  
  To add a new machine (host) to this setup:
  1. Host Specific Config (Optional): Create `./host/` (e.g., `./host/<hostname>/default.nix`). This is optional only, you can override some of the default configs tailored for your own machine
  2. System Level Config (Required): Create `./system/<hostname>/default.nix`. You must import your machine-specific `hardware-configuration.nix` here.
  3. User Level Config (Required): Create `./user/<hostname>/default.nix`. Home Manager strictly requires this file to exist to map your user environment (it can be a blank `{ }` template if unused).
*/
{
  description = "tunitz nixos configs";

  inputs = {
    # Core NixOS repository
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    
    # SDDM Themes
    qylock.url = "github:Darkkal44/qylock";
    
    # Wayland
    hyprland.url = "github:hyprwm/Hyprland";

    # User environment manager
    home-manager = {
      url = "github:nix-community/home-manager";
      # Force home-manager to use the exact same nixpkgs version as the system to prevent conflicts
      inputs.nixpkgs.follows = "nixpkgs"; 
    };

    # KDE Plasma manager (Home Manager module)
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };  
  };

  outputs = { self, nixpkgs, ... } @ inputs: 
  let 
    # Define the directory where host configurations live
    hostDir = ./host;

    # Dynamically scan directories and generate a list of all folder names
    # This prevents you from having to manually hardcode new hostnames into this file
    hostNames = builtins.attrNames (
      nixpkgs.lib.filterAttrs (name: type: type == "directory") (builtins.readDir hostDir)
    );

    # The function that builds the NixOS configuration for each dynamically found host
    mkSystem = host: nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      
      # Pass the flake inputs and the dynamically generated hostname down to all child modules
      specialArgs = { inherit inputs host; };
      
      # Define the module tree. 
      # The `++` operator safely concatenates the mandatory lists with the optional overrides.
      modules = [
        # Base templates (Mandatory for all hosts)
        ./host/default.nix
        ./system/default.nix
        ./system/${host}/default.nix
        ./user/default.nix
      ]

      # Conditionally load host-level overrides ONLY if the user created the file (Optional)
      ++ nixpkgs.lib.optional (builtins.pathExists ./host/${host}/default.nix) ./host/${host}/default.nix;
    };
  in
  {
    # Automatically map the hostNames array through the mkSystem function 
    # Generates outputs like: nixosConfigurations.tunitz
    nixosConfigurations = nixpkgs.lib.genAttrs hostNames mkSystem;
  };
}