{
  description = "Flake for NixOS server";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: 
    let
      pkgs = import nixpkgs {};
    in {
    nixosConfigurations.gw0 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.egor = import ./home.nix;
        }
      ];
    };
    
    homeConfigurations.lab = home-manager.lib.homeManagerConfiguration {
      system = "x86_64-linux";
      inherit pkgs;
      modules = [ ./home.nix ];
    };

    homeConfigurations.mac = home-manager.lib.homeManagerConfiguration {
      system = "x86_64-darwin";
    };
  };
}
