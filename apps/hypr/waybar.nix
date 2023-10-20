{ config, pkgs, ... }:
let
  playerctl_metadata_cmd = "${pkgs.playerctl}/bin/playerctl -a metadata --format '{\"text\": \"{{playerName}}: {{artist}} - {{markup_escape(title)}}\", \"tooltip\": \"{{playerName}} : {{markup_escape(title)}}\", \"alt\": \"{{status}}\", \"class\": \"mediaplayer\"}' -F";
 cssColor = vals: pkgs.lib.foldlAttrs (acc: name: value: acc + "@define-color ${name} ${toString value};\n") "" vals;


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
    style =''
  
  * {
    border: none;
    border-radius: 0;
    padding: 0;
    margin: 0;
  /* `otf-font-awesome` is required to be installed for icons */
    font-family: FontAwesome, Roboto, Helvetica, Arial, sans-serif;
    font-size: 13px;
  }

  window#waybar {
    background-color: rgba(43, 48, 59, 0.5);
    border-bottom: 3px solid rgba(100, 114, 125, 0.5);
    color: #ffffff;
    transition-property: background-color;
    transition-duration: .5s;
}

window#waybar.hidden {
    opacity: 0.2;
}

/*
window#waybar.empty {
    background-color: transparent;
}
window#waybar.solo {
    background-color: #FFFFFF;
}
*/

window#waybar.termite {
    background-color: #3F3F3F;
}

window#waybar.chromium {
    background-color: #000000;
    border: none;
}

button {
    /* Use box-shadow instead of border so the text isn't offset */
    box-shadow: inset 0 -3px transparent;
    /* Avoid rounded borders under each button name */
    border: none;
    border-radius: 0;
}

/* https://github.com/Alexays/Waybar/wiki/FAQ#the-workspace-buttons-have-a-strange-hover-effect */
button:hover {
    background: inherit;
    box-shadow: inset 0 -3px #ffffff;
}

#workspaces button {
    padding: 0 5px;
    background-color: transparent;
    color: #ffffff;
}

#workspaces button:hover {
    background: rgba(0, 0, 0, 0.2);
}

#workspaces button.focused {
    background-color: #64727D;
    box-shadow: inset 0 -3px #ffffff;
}

#workspaces button.urgent {
    background-color: #eb4d4b;
}

#mode {
    background-color: #64727D;
    border-bottom: 3px solid #ffffff;
}

#clock,
#battery,
#cpu,
#memory,
#disk,
#temperature,
#backlight,
#network,
#pulseaudio,
#wireplumber,
#custom-media,
#tray,
#mode,
#idle_inhibitor,
#scratchpad,
#mpd {
    padding: 0 10px;
    color: #ffffff;
}

#window,
#workspaces {
    margin: 0 4px;
}

/* If workspaces is the leftmost module, omit left margin */
.modules-left > widget:first-child > #workspaces {
    margin-left: 0;
}

/* If workspaces is the rightmost module, omit right margin */
.modules-right > widget:last-child > #workspaces {
    margin-right: 0;
}

#clock {
    background-color: #64727D;
}

#battery {
    background-color: #ffffff;
    color: #000000;
}

#battery.charging, #battery.plugged {
    color: #ffffff;
    background-color: #26A65B;
}

@keyframes blink {
    to {
        background-color: #ffffff;
        color: #000000;
    }
}

#battery.critical:not(.charging) {
    background-color: #f53c3c;
    color: #ffffff;
    animation-name: blink;
    animation-duration: 0.5s;
    animation-timing-function: linear;
    animation-iteration-count: infinite;
    animation-direction: alternate;
}

label:focus {
    background-color: #000000;
}

#cpu {
    background-color: #2ecc71;
    color: #000000;
}

#memory {
    background-color: #9b59b6;
}

#disk {
    background-color: #964B00;
}

#backlight {
    background-color: #90b1b1;
}

#network {
    background-color: #2980b9;
}

#network.disconnected {
    background-color: #f53c3c;
}

#pulseaudio {
    background-color: #f1c40f;
    color: #000000;
}

#pulseaudio.muted {
    background-color: #90b1b1;
    color: #2a5c45;
}

#wireplumber {
    background-color: #fff0f5;
    color: #000000;
}

#wireplumber.muted {
    background-color: #f53c3c;
}

#custom-media {
    background-color: #66cc99;
    color: #2a5c45;
    min-width: 100px;
}

#custom-media.custom-spotify {
    background-color: #66cc99;
}

#custom-media.custom-vlc {
    background-color: #ffa000;
}

#temperature {
    background-color: #f0932b;
}

#temperature.critical {
    background-color: #eb4d4b;
}

#tray {
    background-color: #2980b9;
}

#tray > .passive {
    -gtk-icon-effect: dim;
}

#tray > .needs-attention {
    -gtk-icon-effect: highlight;
    background-color: #eb4d4b;
}

#idle_inhibitor {
    background-color: #2d3436;
}

#idle_inhibitor.activated {
    background-color: #ecf0f1;
    color: #2d3436;
}

#mpd {
    background-color: #66cc99;
    color: #2a5c45;
}

#mpd.disconnected {
    background-color: #f53c3c;
}

#mpd.stopped {
    background-color: #90b1b1;
}

#mpd.paused {
    background-color: #51a37a;
}

#language {
    background: #00b093;
    color: #740864;
    padding: 0 5px;
    margin: 0 5px;
    min-width: 16px;
}

#keyboard-state {
    background: #97e1ad;
    color: #000000;
    padding: 0 0px;
    margin: 0 5px;
    min-width: 16px;
}

#keyboard-state > label {
    padding: 0 5px;
}

#keyboard-state > label.locked {
    background: rgba(0, 0, 0, 0.2);
}

#scratchpad {
    background: rgba(0, 0, 0, 0.2);
}

#scratchpad.empty {
	background-color: transparent;
}
  '';


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
  
  
  
  xdg.configFile = {
    "./themes/mocha.css".text = cssColor {
      base = "#1e1e2e";
      mantle = "#181825";
      crust = "#11111b";

      text = "#cdd6f4";
      subtext0 = "#a6adc8";
      subtext1 = "#bac2de";

      surface0 = "#313244";
      surface1 = "#45475a";
      surface2 = "#585b70";

      overlay0 = "#6c7086";
      overlay1 = "#7f849c";
      overlay2 = "#9399b2";

      blue = "#89b4fa";
      lavender = "#b4befe";
      sapphire = "#74c7ec";
      sky = "#89dceb";
      teal = "#94e2d5";
      green = "#a6e3a1";
      yellow = "#f9e2af";
      peach = "#fab387";
      maroon = "#eba0ac";
      red = "#f38ba8";
      mauve = "#cba6f7";
      pink = "#f5c2e7";
      flamingo = "#f2cdcd";
      rosewater = "#f5e0dc";
    };
  };

     

}
