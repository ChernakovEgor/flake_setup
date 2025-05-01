{
  description = "Egor's setup";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      nix-darwin,
      home-manager,
      ...
    }:
    let
      linux_pkgs = import nixpkgs { system = "x86_64-linux"; };
      darwin_pkgs = import nixpkgs { system = "x86_64-darwin"; };
    in
    {
      nixosConfigurations.gw0 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./nixos/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.egor = import ./home-manager/home.nix;
          }
        ];
      };

      nixosConfigurations.takanuwa = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./nixos/takanuwa/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.egor = import ./home-manager/home.nix;
          }
        ];
      };

      homeConfigurations.egor = home-manager.lib.homeManagerConfiguration {
        pkgs = linux_pkgs;
        modules = [
          ./home-manager/home.nix
        ];
      };

      darwinConfigurations."MacBook-Pro-Egor" = nix-darwin.lib.darwinSystem {
        system = "x86_64-darwin";
        modules = [
          ./darwin/configuration.nix
        ];
      };
    };
}
