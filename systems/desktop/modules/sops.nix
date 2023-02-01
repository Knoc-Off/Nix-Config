{ inputs, lib, config, ... }:
{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  sops.defaultSopsFile = ../secrets/secrets.yaml;

  # This is using an age key that is expected to already be in the filesystem
  sops.age.keyFile = "/var/lib/sops-nix/key.txt";
}
