{ config, pkgs, home-manager, self, inputs, lib, ...}:
let
 # oh-my-matrix = import ./apps/common/oh-my-matrix.nix {inherit lib;};
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
    zsh
    firefox
    barrier
    hyprland
    mpvpaper
    mc
    obsidian
    vscode-fhs
    unzip
    dunst
    dolphin
    transmission
    lshw
    discord
    lshw
    htop
    nvtop
    git
#    oh-my-matrix
    ];
}
