{ config, pkgs, ...}:

{
  # if you config gets too long, split it up into smaller modules
  imports = [
   #    ../apps/steam.nix
#    ../apps/code.nix
    ../../apps/hypr/hyprland.nix
    ../../apps/hypr/waybar.nix
    ../../apps/wofi.nix
    ../../apps/barrier.nix
    ../../apps/zshconf.nix
    ../../apps/git.nix # looks for ./git/defualt.nix
    ../../apps/rofi.nix
    ../../apps/kitty.nix
    ../../apps/emacs.nix
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
    obsidian
    vscode-fhs
    unzip
    dunst
    dolphin
    transmission
    nvtop
    htop
    lshw
    ];
}
