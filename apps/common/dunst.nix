{config, pkgs, ...}:

{
    services.dunst = {
        enable = true;
        iconTheme = {
              name = "hicolor";
              package = pkgs.hicolor-icon-theme;
              size = "32x32";
        };
        settings = {
            global = {
    width = 300;
    height = 300;
    offset = "30x50";
    origin = "top-right";
    transparency = 10;
    frame_color = "#eceff1";
    font = "Droid Sans 9";
  };

  urgency_normal = {
    background = "#37474f";
    foreground = "#eceff1";
    timeout = 10;
  };
        };
    };
}