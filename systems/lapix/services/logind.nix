{ inputs, pkgs, libs, ... }:
{
  # Lidswitch Setting
  services.logind.lidSwitch = "suspend-then-hibernate";
  services.logind.extraConfig = ''
    # don’t shutdown when power button is short-pressed
    HandlePowerKey=hibernate
  '';


}
