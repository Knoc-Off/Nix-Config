{ inputs, pkgs, libs, ... }:
{
  # Lidswitch Setting
  services.logind.lidSwitch = "suspend-then-hibernate";


}
