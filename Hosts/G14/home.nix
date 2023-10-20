{ config, pkgs, home-manager, self, inputs, lib, nixpkgs, ...}:

let
  oh-my-matrix = import ./apps/common/oh-my-matrix.nix {inherit lib;};
in 

{
  # if you config gets too long, split it up into smaller modules
  imports = [
      ../../apps/common/common.nix
    ];
    
  # The User and Path it manages
  home.username = "zell";
  home.homeDirectory = "/home/zell";
  home.stateVersion = "23.05";
  
  # Let Home Manager manage itself
  programs.home-manager.enable = true;
  nixpkgs.config = {
    allowUnfree = true;
    experimental-features = "nix-command" "flakes";
  };
  # List of user programs
  home.packages = with pkgs; [
    ohMyMatrix
    zsh
    firefox
    barrier
    obsidian
    vscode-fhs
    unzip
    dunst
    dolphin
    transmission
    nvtop
    htop
    lshw
    discord
    cura
    font-awesome
    vimPlugins.vim-nix
    ];

    gtk = {
      enable = true;
    };

    packages.x86_64-linux.oh-my-matrix = nixpkgs.stdenv.mkDerivation {
      name = "oh-my-matrix";
      src = self.oh-my-matrix;  # Point to the directory structure in your flake.
      installPhase = ''
        mkdir -p $out~/.oh-my-zhs/custom/plugins/oh-my-matrix
        cp -r $src/Plugins/oh-my-zsh/oh-my-matrix/* $out~/.oh-my-zsh/custom/plugins/oh-my-matrix
      '';
    };
}
