{
  description = "hyprland";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
       url = "github:nix-community/home-manager";
       inputs.nixpkgs.follows = "nixpkgs";
    };
  };


 outputs = inputs@{ nixpkgs, home-manager, ... }: {
    nixosConfigurations = {
      hyprland = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./Hosts/P72/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.zell = import ./Hosts/P72/home.nix;

            # Optionally, use home-manager.extraSpecialArgs to pass arguments to home.nix
          }
        ];
      };
    };
  };

    nixosConfigurations = {
      zellmain = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          home-manager.nixModules.home-manager
          ./Hosts/G14/configuration.nix
          {
            home-manager.useGlobalPackages = true;
            home-manager.useUserPackages = true;
            home-manager.users.zell = import ./Hosts/P72/home.nix
          }
        ]
      }
    }

}
