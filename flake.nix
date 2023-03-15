{
  description = "lowfat config";

  nixConfig =
  {
    trusted-substituters = [
      "https://hyprland.cachix.org"
      #"https://app.cachix.org/cache/jakestanger"
    ];
    extra-trusted-public-keys = [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
  };

  inputs = {

    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    unstable-pkgs.url = "github:nixos/nixpkgs/nixos-unstable";


    # Community maintained vimPlugins
    nixneovimplugins.url = "github:jooooscha/nixpkgs-vim-extra-plugins";

    # Neovim nix module
    nixvim.url = "github:pta2002/nixvim";

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };


    prismlauncher.url = "github:PrismLauncher/PrismLauncher";

    hyprland.url = "github:hyprwm/hyprland/v0.17.0beta";

    # Home manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    hardware.url = "github:nixos/nixos-hardware";
    nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs = inputs@ {
    self,
    nix-colors,
    nixpkgs,
    unstable-pkgs,
    home-manager,
    ...
  }:
  {

    nixosConfigurations = {
      lapix = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules =
        [ ./systems/lapix ]; # Laptop
      };
      desktop = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules =
        [ ./systems/desktop ]; # Desktop
      };
    };

    homeConfigurations =
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      unstable = import unstable-pkgs
      {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };

    in
    {
      "knoff@lapix" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit inputs; };
        modules = [ ./home/knoff/lapix.nix ];
        extraSpecialArgs = {
          inherit unstable;
          inherit nix-colors;
        };
      };
      "knoff@desktop" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit inputs; };
        modules = [ ./home/knoff/desktop.nix ];
        extraSpecialArgs = {
          inherit unstable;
        };
      };
    }; # Home manager config.

  };
}
