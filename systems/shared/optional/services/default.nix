{ pkgs, lib, ... }:
{


#  systemd.timers."battery-warn" = {
#    wantedBy = [ "timers.target" ];
#    timerConfig = {
#      OnBootSec = "5m";
#      OnUnitActiveSec = "5m";
#      Unit = "battery-warn.service";
#    };
#  };
#
#  systemd.services."battery-warn" = {
#    script = ''
#      set -eu
#        ${pkgs.libnotify}/bin/notify-send "Battery level is $(level)%!"
#    '';
#    serviceConfig = {
#      Type = "oneshot";
#      User = "knoff";
#    };
#  };
}
