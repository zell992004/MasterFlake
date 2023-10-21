{ config, pkgs,sops-nix, home-manager, self, inputs, lib, nixpkgs, ...}:

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
   # oh-my-matrix
    zsh
    firefox
    barrier
    obsidian
    unzip
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

}
