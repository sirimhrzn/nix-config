{
  config,
  lib,
  pkgs,
  ...
}:
{
  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    settings = {
      monitor = "eDP-1,1920x1080,0x0,1";
      general = {
        gaps_in = 0;
        gaps_out = 0;
        border_size = 2;
        # col.active_border = "rgb(4B0082)";
      };
      input = {
        kb_layout = "us";
        repeat_rate = 80;
        repeat_delay = 300;

        follow_mouse = 1;
        touchpad = {
          natural_scroll = true;
        };
      };
      decoration = {
        rounding = 6;
        blur = {
          enabled = true;
          size = 4;
          passes = 1;
          new_optimizations = true;
        };
      };
      "$mod" = "SUPER";
      bind =
        [
          "$mod, F, exec, firefox"
          ", Print, exec, grimblast copy area"
          "$mod SHIFT,Q ,killactive"
        ]
        ++ (
          # workspaces
          # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
          builtins.concatLists (
            builtins.genList (
              x:
              let
                ws =
                  let
                    c = (x + 1) / 10;
                  in
                  builtins.toString (x + 1 - (c * 10));
              in
              [
                "$mod, ${ws}, workspace, ${toString (x + 1)}"
                "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
              ]
            ) 10
          )
        );
    };
    extraConfig = ''
      exec-once = swww-daemon
      exec-once = nm-applet
      exec-once = blueman-applet 
      exec-once = swww img ~/Downloads/purple.png
      exec-once = waybar
      $mainMod = SUPER
      $terminal = kitty
      bind = $mainMod, D, exec, pkill -x wofi || wofi --show drun
      bind = $mainMod, T, exec, $terminal
      bind = , XF86AudioMute, exec, pamixer --toggle-mute
      bind = , XF86AudioRaiseVolume, exec, pamixer --increase 5
      bind = , XF86AudioLowerVolume, exec, pamixer --decrease 5
      bind = , XF86MonBrightnessUp, exec, brightnessctl set +5%
      bind = , XF86MonBrightnessDown, exec, brightnessctl set 5%-
      bind = $mainMod, P, exec, grimblast copysave area



      windowrule = float,^(rofi)$
    '';
    systemd = {
      enable = true;
    };
  };
}
