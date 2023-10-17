{
  description = "hyprland";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager = {
       url = "github:nix-community/home-manager";
       inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
  };


 outputs = inputs@{ nixpkgs, home-manager, nixos-hardware, hyprland, ... }: 
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};

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
          hyprland.homeManagerModules.default
          {wayland.windowManager.hyprland.enable = true;}
        ];
      };
      zellmain = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./Hosts/G14/configuration.nix
          nixos-hardware.nixosModules.asus-zephyrus-ga401
          home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.zell = ./Hosts/G14/home.nix;
            }
        ];
      };
    };
  };
}

