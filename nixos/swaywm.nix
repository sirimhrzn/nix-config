{
  config,
  lib,
  pkgs,
  ...
}:
let
  smod = config.wayland.windowManager.sway.config.modifier;
in
{
  wayland.windowManager.sway = {
    enable = true;
    checkConfig = false;
    package = pkgs.swayfx;
    config = rec {
      modifier = "Mod4";
      terminal = "kitty";
      startup = [
        { command = "waybar"; }
        { command = "nm-applet"; }
        { command = "blueman-applet"; }
        { command = "swww-daemon"; }
        { command = "swww img ~/Downloads/purple.png"; }
      ];
      keybindings = lib.mkOptionDefault {
        "${smod}+d" = "exec pkill -x rofi || rofi -show drun";
        "${smod}+t" = "exec ${terminal}";
        "XF86AudioMute" = "exec pamixer --toggle-mute";
        "XF86AudioRaiseVolume" = "exec  pamixer --increase 5";
        "XF86AudioLowerVolume" = "exec  pamixer --decrease 5";
        "XF86MonBrightnessUp" = "exec brightnessctl set +5%";
        "XF86MonBrightnessDown" = "exec brightnessctl set 5%-";
        "${smod}+p" = "exec grimblast copysave area";
      };
      bars = [ ];
      input = {
        "type:touchpad" = {
          dwt = "enabled";
          tap = "enabled";
          natural_scroll = "enabled";
        };
        "type:keyboard" = {
          repeat_delay = "300";
          repeat_rate = "80";
        };
      };
      colors = {
        focused = {
          background = "#800080";
          border = "#800080";
          childBorder = "#800080";
          indicator = "#2e9ef4";
          text = "#ffffff";
        };
      };
    };
    extraConfig = ''
      blur enable
      blur_xray disable
      blur_passes 2
      blur_radius 5

      # Window border settings
      default_border pixel 2
      default_floating_border pixel 2
      smart_borders off

      # Additional window rules (optional)
      for_window [app_id=".*"] opacity 0.90
      for_window [class=".*"] opacity 0.90
    '';
  };
}
