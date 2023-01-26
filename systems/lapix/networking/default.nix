{ pkgs, config, libs , ... }:
{
  imports = [
    #./wireguard

  ];

  networking.hostName = "lapix";

}
