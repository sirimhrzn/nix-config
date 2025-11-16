{
  system.defaults.dock = {
    autohide = true;
    showhidden = true; # Translucent.

    mouse-over-hilite-stack = true;

    show-recents = false;
    mru-spaces = false;

    tilesize = 48;
    magnification = false;

    enable-spring-load-actions-on-all-items = true;

    persistent-apps = [
      {app = "/Applications/Zen.app";}
      {app = "/Applications/Alacritty.app";}
    ];

    wvous-bl-corner = 1;
    wvous-br-corner = 1;
    wvous-tl-corner = 1;
    wvous-tr-corner = 1;
  };

  system.defaults.CustomSystemPreferences."com.apple.dock" = {
    autohide-time-modifier = 0.0;
    autohide-delay = 0.0;
    expose-animation-duration = 0.0;
    springboard-show-duration = 0.0;
    springboard-hide-duration = 0.0;
    springboard-page-duration = 0.0;

    launchanim = 0;
  };
}
