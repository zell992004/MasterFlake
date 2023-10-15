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
  homeManagerConfFor = config;

  zellmain = home-manager.lib.homeManagerConfiguration {
    system = "x86_64-linux";
    modules = [
      ./Hosts/G14/Configuration.nix
      home-manager.nixModules.home-manager
      {home-manager.users.zell =
        homeManagerConfFor ./Hosts/G14/Configurations.nix
      };
    ];
    extraSpecialArgs = { inherit nixpkgs; };
  }

  in {
    nixosConfigurations = nixpkgs.lib.nixosSystem {
      hyprland = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./Hosts/P72/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.zell = homeManagerConfFor ./Hosts/P72/home.nix;

            # Optionally, use home-manager.extraSpecialArgs to pass arguments to home.nix
          }
        ];
        specialArgs = {inherit nixpkgs; };
      };
      defaultPackage.x86_64-linux = zellmain.actionPackage;
    };
  }
}
