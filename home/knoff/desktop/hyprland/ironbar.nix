{ pkgs, inputs, config, ... }:
{
  imports = [ 
    inputs.ironbar.homeManagerModules.default
    {
      # And configure
      programs.ironbar = {
        enable = true;
        config = {};
        style = "";
      };
    }
  ];
}
