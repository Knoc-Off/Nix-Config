{
  # A brief description of the flake configuration
  description = "lowfat config";

  # Configure additional binary cache substituters and trusted public keys
  nixConfig = {
    extra-substituters = [ "https://nix-community.cachix.org" ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
  };

  # Define inputs (repositories or packages) used in this flake
  inputs = {

    # Nixpkgs
    #stable-pkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    bl-pkgs.url = "github:nixos/nixpkgs/nixos-unstable"; # can be updated more often
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";

    # Neovim nix module
    nixvim =
      {
        url = "github:pta2002/nixvim";
        #inputs.pkgs.follows = "nixpkgs";
      };

    # Firefox add-ons packaged for Nix
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Prism Launcher
    prismlauncher.url = "github:PrismLauncher/PrismLauncher";

    #Hyprland (custom Linux distribution)
    hyprland = {
      url = "github:hyprwm/hyprland";
      #inputs.nixpkgs.follows = "nixpkgs";
      #inputs.nixpkgs.follows = "nixpkgs";
    };
    #hyprland.url = "github:hyprwm/Hyprland";

    # Home Manager (for managing user environments using Nix)
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # NixOS hardware-specific configurations
    hardware.url = "github:nixos/nixos-hardware";
    nix-colors.url = "github:misterio77/nix-colors";
  };

  # Define the outputs of the flake
  outputs =
    inputs@{ self, nix-colors, nixpkgs, bl-pkgs, home-manager, ... }: {

      # Add an overlay to nixpkgs with your custom package
      overlay = final: prev: { };

      # Define NixOS system configurations (laptop and desktop)
      nixosConfigurations = {
        lapix = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            ./systems/lapix
            #hyprland.nixosModules.default
            #{ programs.hyprland.enable = true; }

          ]; # Laptop configuration
        };
        desktop = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [ ./systems/desktop ]; # Desktop configuration
        };
      };

      # Define Home Manager configurations for the user "knoff" on two systems (lapix and desktop)
      homeConfigurations =
        let
          system = "x86_64-linux";
          overlay = self.overlay;
          pkgs = import nixpkgs {
            inherit system;
            config = { allowUnfree = true; };
            overlays = [ overlay ];
          };
          bled = import bl-pkgs {
            inherit system;
            config = { allowUnfree = true; };
            overlays = [ overlay ];
          };
        in
        {
          "knoff@lapix" = home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            modules = [ ./home/knoff/lapix.nix ];
            extraSpecialArgs = {
              inherit inputs;
              inherit bled;
              inherit nix-colors;
            };
          };
          "knoff@desktop" = home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            modules = [ ./home/knoff/desktop.nix ];
            extraSpecialArgs = {
              inherit inputs;
              inherit bled;
            };
          };
        };
    };
}
