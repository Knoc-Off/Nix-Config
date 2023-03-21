{ pkgs, inputs, config, ... }: {
  imports = [ ./xserver.nix ./logind.nix ./earlyoom.nix ];
  services.fwupd.enable = true;
}
