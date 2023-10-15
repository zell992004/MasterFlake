{ config, pkgs, ...}:

{
  # if you config gets too long, split it up into smaller modules
  imports = [
   #    ../apps/steam.nix
#    ../apps/code.nix
 #   ../../apps/common/hypr/hyprland.nix
 #   ../../apps/common/hypr/waybar.nix
 #   ../../apps/common/barrier.nix
#    ../../apps/common/zshconf.nix
#    ../../apps/common/git.nix # looks for ./git/defualt.nix
#    ../../apps/common/rofi.nix
#    ../../apps/common/kitty.nix
#    ../../apps/common/neovim.nix
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
