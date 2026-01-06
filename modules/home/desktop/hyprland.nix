{
  pkgs,
  lib,
  config,
  ...
}:
let
  inherit (lib) getExe;
  terminal = "${getExe pkgs.foot}";
  fileManager = "${getExe pkgs.xfce.thunar}";
  menu = "${getExe pkgs.fuzzel}";
  uwsm = "${getExe pkgs.uwsm}";
  swaybg = "${getExe pkgs.swaybg}";
  hyprshot = "${getExe pkgs.hyprshot}";
  playerctl = "${getExe pkgs.playerctl}";
  wpctl = "${pkgs.wireplumber}/bin/wpctl";
in
with config.lib.stylix.colors;
{
  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;
    settings = {
      monitor = ",highrr,auto,auto";

      "exec-once" = "${uwsm} app -- swaybg -c 282828";

      general = {
        gaps_in = "0";
        gaps_out = "0";
        border_size = "2";
        "col.active_border" = "rgb(${base0B})";
        "col.inactive_border" = "rgba(928374ff)";
        resize_on_border = "false";
        allow_tearing = "false";
        layout = "dwindle";
      };

      decoration = {
        rounding = "0";
        rounding_power = "0";
        active_opacity = "1.0";
        inactive_opacity = "1.0";
        shadow.enabled = "false";
        blur.enabled = "false";
      };

      animations = {
        enabled = "yes, please :)";
        bezier = [
          "easeOutQuint,   0.23, 1,    0.32, 1"
          "easeInOutCubic, 0.65, 0.05, 0.36, 1"
          "linear,         0,    0,    1,    1"
          "almostLinear,   0.5,  0.5,  0.75, 1"
          "quick,          0.15, 0,    0.1,  1"
        ];
        animation = [
          "global,        1,     10,    default"
          "border,        1,     5.39,  easeOutQuint"
          "windows,       1,     4.79,  easeOutQuint"
          "windowsIn,     1,     4.1,   easeOutQuint, popin 87%"
          "windowsOut,    1,     1.49,  linear,       popin 87%"
          "fadeIn,        1,     1.73,  almostLinear"
          "fadeOut,       1,     1.46,  almostLinear"
          "fade,          1,     3.03,  quick"
          "layers,        1,     3.81,  easeOutQuint"
          "layersIn,      1,     4,     easeOutQuint, fade"
          "layersOut,     1,     1.5,   linear,       fade"
          "fadeLayersIn,  1,     1.79,  almostLinear"
          "fadeLayersOut, 1,     1.39,  almostLinear"
          "workspaces,    1,     1.94,  easeOutQuint, slide"
          "workspacesIn,  1,     1.21,  easeOutQuint, slide"
          "workspacesOut, 1,     1.94,  easeOutQuint, slide"
          "zoomFactor,    1,     7,     quick"
        ];
      };

      dwindle.pseudotile = "true";
      dwindle.preserve_split = "true";

      master.new_status = "master";

      misc.force_default_wallpaper = "-1";
      misc.disable_hyprland_logo = "false";

      input = {
        kb_layout = "us,ru";
        kb_variant = "";
        kb_model = "";
        kb_options = "grp:win_space_toggle";
        kb_rules = "";
        follow_mouse = "1";
        sensitivity = "0";
        touchpad.natural_scroll = "false";
      };

      "$mainMod" = "SUPER";

      bind = [
        "$mainMod, return, exec, ${terminal}"
        "$mainMod SHIFT, Q, killactive,"
        "$mainMod SHIFT, E, exit,"
        "$mainMod, E, exec, ${fileManager}"
        "$mainMod, V, togglefloating,"
        "$mainMod, D, exec, ${menu}"
        "$mainMod SHIFT, S, exec, ${hyprshot} --clipboard-only -zm region"
        "$mainMod CONTROL, right, workspace, e+1"
        "$mainMod CONTROL, left, workspace, e-1"
        "$mainMod, L, movefocus, r"
        "$mainMod, H, movefocus, l"
        "$mainMod, K, movefocus, u"
        "$mainMod, J, movefocus, d"
        "$mainMod SHIFT, L, movewindow, r"
        "$mainMod SHIFT, H, movewindow, l"
        "$mainMod SHIFT, K, movewindow, u"
        "$mainMod SHIFT, J, movewindow, d"
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"
      ];

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      bindel = [
        ",XF86AudioRaiseVolume, exec, ${wpctl} set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, ${wpctl} set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, exec, ${wpctl} set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioMicMute, exec, ${wpctl} set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ",XF86MonBrightnessUp, exec, brightnessctl s 10%+"
        ",XF86MonBrightnessDown, exec, brightnessctl s 10%-"
      ];

      bindl = [
        ", XF86AudioNext, exec, ${playerctl} next"
        ", XF86AudioPause, exec, ${playerctl} play-pause"
        ", XF86AudioPlay, exec, ${playerctl} play-pause"
        ", XF86AudioPrev, exec, ${playerctl} previous"
      ];

      windowrule = [
        "suppressevent maximize, class:.*"
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
      ];
    };
  };
}
