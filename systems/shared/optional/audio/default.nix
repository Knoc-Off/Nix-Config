{ inputs, pkgs, config, ...}:
{
  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  # realtime scheduling priority, only needed for pulseaudio?
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true; 
    jack.enable = true;
  };
}
