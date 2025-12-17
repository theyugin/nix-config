{ pkgs, lib, ... }:
let
  inherit (lib) getExe;
  hyprctl = "${pkgs.hyprland}/bin/hyprctl";
  curl = "${getExe pkgs.curl}";
  systemctl = "${pkgs.systemd}/bin/systemctl";
in
{
  programs.waybar = {
    enable = true;
    settings = {
      main = {
        position = "bottom";
        height = 30;
        spacing = 5;

        modules-left = [
          "hyprland/workspaces"
          "hyprland/submap"
          "mpris"
        ];
        modules-center = [ "hyprland/window" ];
        modules-right = [
          "custom/weather"
          "cpu"
          "memory"
          "hyprland/language"
          "clock"
          "tray"
          "custom/power"
        ];

        "hyprland/workspaces" = {
          on-scroll-up = "${hyprctl} dispatch workspace e-1";
          on-scroll-down = "${hyprctl} dispatch workspace e+1";
        };
        "hyprland/submap" = {
          format = "<span style=\"italic\">{}</span>";
        };
        "mpris" = {
          format = "{artist} - {title}";
          ignored-players = [ "firefox" ];
        };

        "hyprland/window" = {
          on-scroll-up = "${hyprctl} dispatch workspace e-1";
          on-scroll-down = "${hyprctl} dispatch workspace e+1";
        };

        "custom/weather" = {
          interval = 600;
          exec = "${curl} -s 'wttr.in/Yekaterinburg?format=3'";
        };
        "cpu" = {
          format = "{usage}%  ";
          tooltip = false;
        };
        "memory" = {
          format = "{}%  ";
        };
        "hyprland/language" = {
          format-en = "en";
          format-ru = "ru";
        };
        "clock" = {
          format = "{:%H:%M:%S}";
          interval = 1;
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          format-alt = "{:%Y-%m-%d}";
        };

        "tray" = {
          spacing = 10;
        };
        "custom/power" = {
          format = "⏻ ";
          tooltip = false;
          menu = "on-click";
          menu-file = pkgs.writeText "power-menu.xml" /* xml */ ''
            <?xml version="1.0" encoding="UTF-8"?>
            <interface>
              <object class="GtkMenu" id="menu">
                <child>
                  <object class="GtkMenuItem" id="shutdown">
                    <property name="label">Shutdown</property>
                  </object>
                </child>
                <child>
                  <object class="GtkSeparatorMenuItem" id="delimiter1"/>
                </child>
                <child>
                  <object class="GtkMenuItem" id="reboot">
                    <property name="label">Reboot</property>
                  </object>
                </child>
              </object>
            </interface>
          '';
          menu-actions = {
            shutdown = "${systemctl} poweroff";
            reboot = "${systemctl} reboot";
          };
        };
      };
    };
    style = lib.mkAfter /* css */ ''
      * {
          font-family: monospace;
          font-size: 15pt;
      }

      window#waybar {
          background-color: #282828;
          color: #ebdbb2;
          transition-property: background-color;
          transition-duration: .5s;
      }

      window#waybar.hidden {
          opacity: 0.2;
      }

      button {
          box-shadow: inset 0 -3px transparent;
          border: none;
          border-radius: 0;
      }

      button:hover {
          background: inherit;
          box-shadow: inset 0 -3px #ebdbb2;
      }

      #custom-separator {
          font-size: 20px;
      }

      #workspaces button {
          padding: 0 5px;
          background-color: transparent;
          color: #ebdbb2;
      }

      #workspaces button:hover {
          background: rgba(0, 0, 0, 0.2);
      }

      #workspaces button.active {
          background-color: #92971a;
          box-shadow: inset 0 -3px #ebdbb2;
      }

      #workspaces button.urgent {
          background-color: #cc241d;
      }

      #mode {
          background-color: #64727D;
          box-shadow: inset 0 -3px #ffffff;
      }

      #clock,
      #battery,
      #cpu,
      #memory,
      #disk,
      #temperature,
      #backlight,
      #network,
      #language,
      #pulseaudio,
      #wireplumber,
      #tray,
      #mode,
      #custom-weather,
      #keyboard-state,
      #mpd {
          padding: 0 7px 0 5px;
          border-right: 2px solid #928374;
      }

      #custom-power {
          padding: 0 7px 0 5px;
      }

      #window,
      #workspaces {
          margin: 0 4px;
      }

      .modules-left > widget:first-child > #workspaces {
          margin-left: 0;
      }

      @keyframes blink {
          to {
              background-color: #ffffff;
              color: #000000;
          }
      }

      #pulseaudio {
          color: #fabd2f;
      }

      #pulseaudio.muted {
          color: #fb4934;
      }

      #cpu {
          color: #83a598;
      }

      #memory {
          color: #d3869b;
      }

      #language {
          color: #8ec07c;
      }
    '';
  };
}
