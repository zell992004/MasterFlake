{
  description = "hyprland";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nixpkgs-vscode.url = "github:nixos/nixpkgs/db9208ab987cdeeedf78ad9b4cf3c55f5ebd269b";
   # sops-nix.url = "github:mic92/sops-nix";
   # nixpkgs-oh-my-matrix.dir = "./apps/oh-my-matrix.nix";
    home-manager = {
       url = "github:nix-community/home-manager";
       inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
  };
 outputs = inputs@{ nixpkgs, home-manager, nixos-hardware, hyprland, self, sops-nix, ... }: 
  let
    system = "x86_64-linux";
    inherit (hyprland.inputs) nixpkgs;

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
            # Optionally, use home-manager.extraSpecialArgs to pass arguments to home.nix like this
            home-manager.extraSpecialArgs = {inherit inputs;};
          }
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
              home-manager.extraSpecialArgs = {inherit inputs;};
            }
            
        ];
      };

      	
		      work = nixpkgs.lib.nixosSystem {
			      system = "x86_64-linux";
			      specialArgs = {inherit inputs; };
			    modules = [
				    nixos-hardware.nixosModules.lenovo-thinkpad-t480
				    ./Hosts/work/configuration.nix
				    home-manager.nixosModules.home-manager
					    {
					    home-manager.useGlobalPkgs = true;
					    home-manager.useUserPackages = true;
					    home-manager.users.peter = ./Hosts/work/home.nix;
              home-manager.extraSpecialArgs = {inherit inputs;};

					    }
				  ];
      };


  };
};
}

