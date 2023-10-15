{
    imports = [
          #    ../apps/steam.nix
#    ../apps/code.nix
    ./apps/common/hypr/hyprland.nix
    ./apps/common/hypr/waybar.nix
    ./apps/common/barrier.nix
    ./apps/common/zshconf.nix
    ./apps/common/git.nix # looks for ./git/defualt.nix
    ./apps/common/rofi.nix
    ./apps/common/kitty.nix
    ./common/neovim.nix
    ];
}