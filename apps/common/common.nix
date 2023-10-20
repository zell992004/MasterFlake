{ ... }:{
    imports = [
          #    ../apps/steam.nix
    ./code.nix
    ../hypr/hyprland.nix
    ../hypr/waybar.nix
    ./barrier.nix
    ./zshconf.nix
    ./git.nix # looks for ./git/defualt.nix
    ./rofi.nix
    ./kitty.nix
    ./neovim.nix
#    ./dunst.nix
     ./smallsnips.nix
    ];
}