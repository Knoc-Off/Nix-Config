{ pkgs, config, lib, ... }:
let inherit (config.colorscheme) colors;
in {

  home.packages = with pkgs; [ swaylock swayidle ];

  programs.swaylock.settings = {
    color = "${colors.base02}";
    font-size = 24;
    indicator-idle-visible = true;
    indicator-radius = 100;
    line-color = "${colors.base06}";
    show-failed-attempts = true;
  };

  services.swayidle = {
    enable = true;
    events = [
      {
        event = "before-sleep";
        command = "${pkgs.swaylock}/bin/swaylock";
      }
      {
        event = "lock";
        command = "lock";
      }
    ];

    timeouts = [{
      timeout = 60;
      command = "${pkgs.swaylock}/bin/swaylock -fF";
    }];
  };
}
