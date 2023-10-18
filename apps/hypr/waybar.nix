{ config, pkgs, ... }:
let
  playerctl_metadata_cmd = "${pkgs.playerctl}/bin/playerctl -a metadata --format '{\"text\": \"{{playerName}}: {{artist}} - {{markup_escape(title)}}\", \"tooltip\": \"{{playerName}} : {{markup_escape(title)}}\", \"alt\": \"{{status}}\", \"class\": \"mediaplayer\"}' -F";
 #cssColor = vals: pkgs.lib.foldlAttrs (acc: name: value: acc + "@define-color ${name} ${toString value};\n") "" vals;

  waybar-hyprland = pkgs.waybar.overrideAttrs (oldAttrs: {
    mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
    postPatch = ''
      # use hyprctl to switch workspaces
      sed -i 's|zext_workspace_handle_v1_activate(workspace_handle_);|const std::string command = "${pkgs.hyprland}/bin/hyprctl dispatch workspace " + name_;\n\tsystem(command.c_str());|g' src/modules/wlr/workspace_manager.cpp
    '';
  });
in
{
  programs.waybar = {
    enable = true;
    package = waybar-hyprland;
#    style = {
#       css = {"./themes/mocha.css"}
#       };

    settings = with pkgs; {
      topBar = {
        layer = "top";
        position = "bottom";

        modules-left = [ "clock" ];

        modules-center = [ "wlr/workspaces" ];

        modules-right = [
          "custom/medialeft"
          "custom/media"
          "custom/mediaright"
          "pulseaudio"
          "temperature"
          "custom/fan"
          "network"
          "battery"
        ];

        battery = {
          states = {
            good = 90;
            warning = 50;
            critical = 25;
          };
          format = "{icon} {capacity}%";
          format-alt = "{timeTo}";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ];
        };

        network = {
          format = "{ifname}";
          format-wifi = " {essid} ({signalStrength}%)";
          format-ethernet = " {ipaddr}/{cidr}";
          on-click = "kitty --class floatingkitty --detach nmtui";
        };


        "custom/fan" = {
          exec = "echo {\\\"alt\\\":\\\"$(asusctl profile -p | grep -oE '[^ ]+$')\\\", \\\"tooltip\\\":\\\"$(asusctl profile -p | grep -oE '[^ ]+$')\\\"}";
          return-type = "json";
          interval = "once";
          exec-on-event = true;
          on-click = "asusctl profile -n";
          format = "{icon}";
          format-icons = {
            Performance = "";
            Balanced = "";
            Quiet = "";
          };
        };


        "custom/medialeft" = {
          format = "  ";
          return-type = "json";
          max-length = 70;
          exec = playerctl_metadata_cmd;
          on-click = "${playerctl}/bin/playerctl previous";
        };
        "custom/media" = {
          format = "{icon}";
          return-type = "json";
          format-icons = {
            Playing = " ";
            Paused = " ";
          };
          max-length = 70;
          exec = playerctl_metadata_cmd;
          on-click = "${playerctl}/bin/playerctl play-pause";
        };
        "custom/mediaright" = {
          format = " ";
          return-type = "json";
          max-length = 70;
          exec = playerctl_metadata_cmd;
          on-click = "${playerctl}/bin/playerctl next";
        };

        "hyprland/workspaces" = {
          format = "{name}";
          on-click = "activate";
        };

        clock = {
          format = "{:%F    %H:%M}";
          tooltip = false;
        };

        pulseaudio = {
          format = "{icon} {volume:2}%";
          format-muted = " {volume:2}%";
          format-icons = [ "" "" ];
          scroll-step = 0;
          # TODO: what package is wpctl in?
          on-click = "wpctl set-mute @DEFAULT_SINK@ toggle";
          on-click-right = "${pavucontrol}/bin/pavucontrol";
        };

        temperature = {
          hwmon-path = "/sys/class/hwmon/hwmon4/temp1_input";
          format = "{temperatureC}°C";
          format-alt = "{temperatureF}°F";
        };
      };
    };
};
}