{pkgs, config, libs, ...}:
{
  home.file.".ssh/config".text = builtins.readFile ../configs/ssh.conf;
}
