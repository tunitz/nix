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
    host = "tunitz";
  in
  {
    nixosConfigurations.${host} = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs host; };
      
      modules = [
        ./host/${host}/default.nix # User related config
        ./system/default.nix # Global system config
        ./system/${host}/default.nix # User-related system config
        
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
  };
}
