{ pkgs, inputs, config, ... }: {
  imports = [
    ./xserver.nix
    ./logind.nix
    ./earlyoom.nix
    ./syncthing.nix
  ];
  services.fwupd.enable = true;
  #services.timesyncd.enable = true;


  # Create custom systemd timer that runs every day, and clears the journal logs of the past 2 weeks
  systemd.services.clear-journal = {
    description = "Clear journal logs";
    wantedBy = [ "timers.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.systemd}/bin/journalctl --vacuum-time=14d";
    };
  };

}
