{
  description = "wolk's nixos config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    ab-download-manager-src = {
      url = "https://github.com/amir1376/ab-download-manager/releases/download/v1.8.7/ABDownloadManager_1.8.7_linux_x64.tar.gz";
      flake = false;
    };
    spotiflac-src = {
      url = "https://github.com/spotbye/SpotiFLAC/releases/latest/download/SpotiFLAC.AppImage";
      flake = false;
    };
    prismlauncher-cracked-src = {
      url = "https://github.com/Diegiwg/PrismLauncher-Cracked/releases/download/11.0.2-1/PrismLauncher-Linux-Qt6-Portable-11.0.2-1.tar.gz";
      flake = false;
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      spotiflac-src,
      ab-download-manager-src,
      prismlauncher-cracked-src,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      packages.${system} = {
        # 2. UPDATE THIS: Pass 'spotiflac-src' into the package
        ab-download-manager = pkgs.callPackage ./pkgs/ab-download-manager.nix {
          srcOverride = ab-download-manager-src;
        };
        # In packages.${system}:
        prismlauncher-cracked = pkgs.callPackage ./pkgs/prismlauncher-cracked.nix {
          srcOverride = prismlauncher-cracked-src;
        };
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
