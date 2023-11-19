{ inputs, pkgs, config, ... }:
{
  # Enable sound with pipewire.
  #hardware.pulseaudio.enable = false;
  #hardware.pulseaudio.support32Bit = true; ## If compatibility with 32-bit applications is desired.

  #nixpkgs.config.pulseaudio = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };
  #hardware.pulseaudio.configFile = pkgs.runCommand "default.pa" { } ''
  #  sed 's/module-udev-detect$/module-udev-detect tsched=0/' \
  #    ${pkgs.pulseaudio}/etc/pulse/default.pa > $out
  #'';
}
