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

  outputs = {self, nixpkgs, ...}@inputs: 
  let 
    hostDir = ./host;

    hostNames = builtins.attrNames (
      nixpkgs.lib.filterAttrs (name: type: type == "directory") (builtins.readDir hostDir)
    );

    mkSystem = host: nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs host; };
      
      modules = [
        ./host/default.nix
        ./host/${host}/default.nix
        ./system/default.nix
        ./system/${host}/default.nix
        ./user/default.nix
      ];
    };
  in
  {
    nixosConfigurations = nixpkgs.lib.genAttrs hostNames mkSystem;
  };
}