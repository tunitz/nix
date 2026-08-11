{
  description = "My flakey-oh";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };  
  };

  outputs = {self, nixpkgs, home-manager, ...}@inputs: 
  let 
    hostDir = ./host;

    # Get all directory names inside ./host
    hostNames = builtins.attrNames (
      nixpkgs.lib.filterAttrs (name: type: type == "directory") (builtins.readDir hostDir)
    );

    # Use 'host' instead of 'hostname' to match your module arguments
    mkSystem = host: nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs host; };
      
      modules = [
        ./host/${host}/default.nix
        ./system/default.nix
        ./system/${host}/default.nix
        
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";
          home-manager.extraSpecialArgs = { inherit inputs host; };
          home-manager.users.${host} = import ./user/${host}/default.nix;
        }
      ];
    };
  in
  {
    # Automatically map all host folders to nixosConfigurations
    nixosConfigurations = nixpkgs.lib.genAttrs hostNames mkSystem;
  };
}