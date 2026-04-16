{
  description = "wolk's nixos config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser.url = "github:0xc000022070/zen-browser-flake";

    # 1. ADD THIS: Point to the 'latest' release download
    spotiflac-src = {
      url = "https://github.com/spotbye/SpotiFLAC/releases/latest/download/spotiflac-linux-bundle.tar.gz";
      flake = false;
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      spotiflac-src,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      packages.${system} = {
        # 2. UPDATE THIS: Pass 'spotiflac-src' into the package
        spotiflac = pkgs.callPackage ./pkgs/spotiflac.nix {
          srcOverride = spotiflac-src;
        };
        default = self.packages.${system}.spotiflac;
      };

      nixosConfigurations.nixos-btw = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          { nixpkgs.hostPlatform = system; }
          ./hosts/nixos-btw
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
