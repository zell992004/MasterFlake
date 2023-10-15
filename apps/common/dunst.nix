{config, pkgs, ...}:

{
    services.dunst = {
        enable = true;
        hicolorTheme = {
            package = pkgs.hicolor-theme;
            name = "hicolor";
            size = "32x32";
        };
    };
}