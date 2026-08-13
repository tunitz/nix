/**
  Master Flake Configuration

  WARNING: CORE INFRASTRUCTURE FILE. Do not casually modify the logic in this file. 
  This file acts as the central orchestrator for the entire NixOS setup. It dynamically reads the directory structure to generate machine configurations.
  
  To add a new machine (host) to this setup:
  1. Host Specific Config (Optional): Create `./host/` (e.g., `./host/<hostname>/default.nix`). This is optional only, you can override some of the default configs tailored for your own machine
  2. System Level Config (Required): Create `./system/<hostname>/default.nix`. You must import your machine-specific `hardware-configuration.nix` here.
  3. User Level Config (Optional): Create `./user/<hostname>/default.nix`. This is optional only, you can ovverride some of the default configs tailored for your own machine
*/
{
  description = "tunitz nixos configs";

  inputs = {
    # Core NixOS repository
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    
    # SDDM Themes
    qylock.url = "github:Darkkal44/qylock";

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

  outputs = { self, nixpkgs, home-manager, ... } @ inputs: 
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
        # Base NixOS templates (Mandatory for all hosts)
        ./host/default.nix
        ./system/default.nix
        ./system/${host}/default.nix

        home-manager.nixosModules.home-manager

        # Core Home Manager Configuration
        ({
          home-manager = {
            # Use the system-level Nixpkgs instead of managing a separate instance for the user
            useGlobalPkgs = true;
            
            # Install user packages directly to /etc/profiles/per-user instead of ~/.nix-profile
            useUserPackages = true;
            
            # Automatically backup existing dotfiles (e.g., .bashrc -> .bashrc.backup) 
            # to prevent build failures when Home Manager tries to manage them
            backupFileExtension = "backup";
            
            # Pass flake inputs and the host variable down to your user-level configurations
            extraSpecialArgs = { inherit inputs host; };
            
            # Dynamically map the primary user to their dedicated configuration folder
            users.${host} = {
              # This merges your base user template with the optional host-specific user template
              imports = [
                ./user/default.nix
              ]
              ++ nixpkgs.lib.optional (builtins.pathExists ./user/${host}/default.nix) ./user/${host}/default.nix;
            };
          };
        })
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