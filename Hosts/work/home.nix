{ config, pkgs, home-manager, self, inputs, ... }:

{

  imports = [
    ../../apps/common/common.nix
  ];
  
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "peter";
  home.homeDirectory = "/home/peter";


  programs.home-manager.enable = true;
  nixpkgs.config = {
    allowUnfree = true;
    experimental-features = "nix-command" "flakes";
  };

  home.packages = with pkgs; [
    zsh
    firefox
    barrier
    hyprland
    mpvpaper
    mc
    obsidian
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
    pkgs-vscode
    ];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.05";
}
