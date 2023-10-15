{
  description = "hyprland";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
       url = "github:nix-community/home-manager";
       inputs.nixpkgs.follows = "nixpkgs";
    };
  };


 outputs = inputs@{ nixpkgs, home-manager, ... }: 
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system}
#  homeManagerConfFor = config:

#  zellmain = home-manager.lib.homeManagerConfiguration {
#    system = "x86_64-linux";
#    modules = [
#      ./Hosts/G14/Configuration.nix
#      {
#        home-manager.users.zell = homeManagerConfFor ./Hosts/G14/Configurations.nix;
#       }
#      ];
#    extraSpecialArgs = { inherit nixpkgs; };
#  };

 in {
    nixosConfigurations = {
      hyprland = nixpkgs.lib.nixosSystem {
        modules = [
          ./Hosts/P72/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.zell = ./Hosts/P72/home.nix;

            # Optionally, use home-manager.extraSpecialArgs to pass arguments to home.nix
          }
        ];
      };
      zellmain = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./Hosts/G14/Configuration.nix
            {
              home-manager.users.zell = ./Hosts/G14/Configurations.nix;
            }
        ];
    extraSpecialArgs = { inherit nixpkgs; };
        };

    };
  }

