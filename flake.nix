{
  description = "wolk's nixos config";

  inputs = {
    # We point the main nixpkgs to unstable
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";     

    home-manager = {
      # Point home-manager to the master/unstable branch to match nixpkgs
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser.url = "github:0xc000022070/zen-browser-flake";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: 
  let
    system = "x86_64-linux";
  in {
    nixosConfigurations.nixos-btw = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; }; 
      modules = [
        { nixpkgs.hostPlatform = system; } 
        
        ./hosts/nixos-btw/configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            extraSpecialArgs = { inherit inputs; };
            useGlobalPkgs = true;
            useUserPackages = true;
            users.wolk = import ./home.nix;
            backupFileExtension = "backup";
          };
        }
      ];
    };
  };
}
