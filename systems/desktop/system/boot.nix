{ pkgs, config, lib, ... }:
{
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  boot.initrd.kernelModules = [ "amdgpu" ];

  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  # Enable swap on luks
  boot.initrd.luks.devices."luks-31c1a27a-92f1-42d3-95f5-c94a3991eb89".device = "/dev/disk/by-uuid/31c1a27a-92f1-42d3-95f5-c94a3991eb89";
  boot.initrd.luks.devices."luks-31c1a27a-92f1-42d3-95f5-c94a3991eb89".keyFile = "/crypto_keyfile.bin";



  hardware.opengl.extraPackages = with pkgs; [
    rocm-opencl-icd
    rocm-opencl-runtime
    amdvlk
  ];

  hardware.opengl.driSupport = true;
  # For 32 bit applications
  hardware.opengl.driSupport32Bit = true;
  
  hardware.enableAllFirmware = true;

  networking.networkmanager.enable = true;
  
  # hardware.opengl.extraPackages = with pkgs; [
  # ];
  # For 32 bit applications 
  # Only available on unstable
  # hardware.opengl.extraPackages32 = with pkgs; [
  #   unstable.driversi686Linux.amdvlk
  # ];
}
