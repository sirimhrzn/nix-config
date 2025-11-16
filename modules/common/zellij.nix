{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) enabled mkAfter;
  package = pkgs.zellij;
in {
  home-manager.sharedModules = [
    {
      programs.zellij = enabled {
        inherit package;
        settings = {
          theme = "gruvbox-dark";
          on_force_close = "detach";
          simplified_ui = true;
          default_shell = "nu";
          show_startup_tips = false;
          show_release_notes = false;
          default_layout = "main";
          pane_frames = false;
          copy_command = "pbcopy";
          copy_on_select = true;
        };
      };
      xdg.configFile."zellij/layouts/main.kdl".text =
        mkAfter
        /*
        kdl
        */
        ''
          layout {
            pane borderless=true size=1 {
              plugin location="file:${pkgs.zjstatus}/bin/zjstatus.wasm" {
                format_left  "#[fg=#282828,bg=#d5c4a1,bold]{tabs}"
                format_right "#[fg=#282828,bg=#d5c4a1,bold]{datetime}"
                format_space "#[bg=#3c3836]"
                tab_normal   "#[fg=#ebdbb2,bg=#504945] {index} {name} "
                tab_active   "#[fg=#282828,bg=#fabd2f,bold] {index} {name} "
                datetime          " {format} "
                datetime_format   "%H:%M %d-%b-%y"
                datetime_timezone "Asia/Kathmandu"
              }
            }
            pane split_direction="vertical" {
                pane borderless=true 
            }
          }
        '';
    }
  ];
}
