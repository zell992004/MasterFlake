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


 outputs = inputs@{ nixpkgs, home-manager, nixos-hardware, hyprland, self, ... }: 
  let
    system = "x86_64-linux";
 #   pkgs = nixpkgs.legacyPackages.${system};
    inherit (hyprland.inputs) nixpkgs;
    withPkgsFor = fn: nixpkgs.lib.genAttrs (builtins.attrNames hyprland.packages) (system: fn system.legacyPackages.${system});

 #       packages = withPkgsFor (system: pkgs: {
#	hyprbars = pkgs.callPackage ./hyprbars {
#		inherit (hyprland.packages.${system}) hyprland;
#		stdenv = pkgs.gcc13Stdenv;
#		};
#	});

 in{
     nixosConfigurations = {
      hyprland = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs; }; 
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
        specialArgs = {inherit inputs; }; 
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

#    devShells = withPkgsFor (system: pkgs: {
#    	default = pkgs.mkshell.override {stdenv = pkgs.gcc13Stdenv;} {
#		name = "hyprland-plugins";
#		buildInputs = [hyprland.packages.${system}.hyprland];
#		inputsFrom = [hyprland.packages.${system}.hyprland];
#		};
#	});

  };
}

