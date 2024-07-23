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
        "col.active_border" = "rgb(4B0082)";
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
          size = 5;
          passes = 3;
          new_optimizations = true;
        };
      };
      "$mod" = "SUPER";
      bind =
        [
          ", Print, exec, grimblast copy area"
          "$mod SHIFT,Q ,killactive"
        ]
        ++ (builtins.concatLists (
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
        ));
    };
    extraConfig = ''
      exec-once = swww-daemon
      exec-once = nm-applet
      exec-once = blueman-applet 
      exec-once = swww img ~/Downloads/purpleeyes.png
      exec-once = waybar
      $mainMod = SUPER
      $terminal = kitty
      $night_light_on = wlsunset -T 4500
      $night_light_off = pkill wlsunset

      bind = SUPER ALT, N, exec, $night_light_on || $night_light_off
      bind = $mainMod, D, exec, pkill -x wofi || wofi --show drun
      bind = $mainMod, T, exec, $terminal
      bind = , XF86AudioMute, exec, pamixer --toggle-mute
      bind = , XF86AudioRaiseVolume, exec, pamixer --increase 5
      bind = , XF86AudioLowerVolume, exec, pamixer --decrease 5
      bind = , XF86MonBrightnessUp, exec, brightnessctl set +5%
      bind = , XF86MonBrightnessDown, exec, brightnessctl set 5%-
      bind = $mainMod, P, exec, grimblast copysave area
      bind = $mainMod, F, fullscreen, 0
      bind = $mainMod, V, togglefloating,
      bind = $mainMod, H, movefocus, l
      bind = $mainMod, L, movefocus, r
      bind = $mainMod, K, movefocus, u
      bind = $mainMod, J, movefocus, d


      env = WLR_RENDERER,pixman
      env = WLR_NO_HARDWARE_CURSORS,1
      windowrule = float,^(rofi|blue.*)$
      windowrule = opacity 0.7 0.6,^(Alacritty|kitty|postman.*|wezterm-gui)$
      # windowrule = blur,^(kitty)$
    '';
    systemd = {
      enable = true;
    };
  };
}
