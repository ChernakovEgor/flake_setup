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
      linux_pkgs = import nixpkgs { system = "x86_64-linux";};
      darwin_pkgs = import nixpkgs { system = "x86_64-darwin";};
    in 
    {
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
      pkgs = linux_pkgs;
      modules = [ 
          ./common/home.nix
        ];
    };

    homeConfigurations.mac = home-manager.lib.homeManagerConfiguration {
      pkgs = darwin_pkgs;
    };
    
  };
}
