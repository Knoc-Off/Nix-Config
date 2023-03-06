{ pkgs, config, nix-colors, ... }: 
{
  imports = [
    nix-colors.homeManagerModule
  ];

  #colorScheme = nix-colors.colorSchemes.dracula;

  #colorScheme = nix-colors.lib-core.schemeFromYAML "cool-scheme" 
  #  (builtins.readFile (builtins.fetchUrl "https://raw.githubusercontent.com/chriskempson/base16-default-schemes/master/default-dark.yaml"));

  colorScheme = {
    slug = "My-Theme";
    name = "my-theme";
    author = "Just Testing";
    colors = {
      # Basic colors, UI, Main theming
      base00 = "#131415";
      base01 = "#1a1c1d";
      base02 = "#1d1f21";
      base03 = "#242628";
      base04 = "#393b3c";
      base05 = "#8b8c8d";
      base06 = "#e8e8e8";
      base07 = "#f8f8f8";
      base08 = "#e5727b";
      base09 = "#e59c70";
      base0A = "#e3c262";
      base0B = "#88b656";
      base0C = "#6d988b";
      base0D = "#3f84ba";
      base0E = "#6177a6";
      base0F = "#766d91";
      # ROYGBIV, for more specific colors
      base10 = "#ff595e"; 
      base11 = "#ff7655";
      base12 = "#ff924c";
      base13 = "#ffae43";
      base14 = "#ffca3a";
      base15 = "#e2ca35";
      base16 = "#b6ca2e";
      base17 = "#9cc429";
      base18 = "#52a675";
      base19 = "#36949d";
      base1A = "#1982c4";
      base1B = "#2e75b8";
      base1C = "#4267ac";
      base1D = "#565aa0";
      base1E = "#6a4c93";
      base1F = "#7d63a1";
      # wont be compatible but eh who cares.
    };
  };
}
