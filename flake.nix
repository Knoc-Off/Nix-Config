{
  # A brief description of the flake configuration
  description = "My personal NixOS configuration";

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
    nixvim-flake.url = "github:knoc-off/neovim-config";
    # Nixpkgs
    #stable-pkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    unstable-packages.url = "github:nixos/nixpkgs/nixos-unstable"; # can be updated more often
    # I want to make the unstable packages the default for home manager,
    # while keeping the stable packages for the system
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";

    # Firefox add-ons packaged for Nix
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Hyprland
    hyprland = {
      url = "github:hyprwm/hyprland";
    };

    # Home Manager (for managing user environments using Nix)
    home-manager.url = "github:nix-community/home-manager/release-23.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # NixOS hardware-specific configurations
    hardware.url = "github:nixos/nixos-hardware";
    nix-colors.url = "github:misterio77/nix-colors";
  };

  # Define the outputs of the flake
  outputs =
    inputs@{ self, nix-colors, nixpkgs, unstable-packages, home-manager, ... }:

    let
      inherit (self) outputs;
    in
    {

      # Your custom packages and modifications, exported as overlays
      overlays = import ./overlays { inherit inputs; };

      # Define NixOS system configurations (laptop and desktop)
      nixosConfigurations = {
        lapix = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [
            ./systems/lapix
          ]; # Laptop configuration
        };
        desktop = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [
            ./systems/desktop
          ];
        };
      };

      # Define Home Manager configurations for the user "knoff" on two systems (lapix and desktop)
      homeConfigurations =
        let
          system = "x86_64-linux";
          #          #overlay = self.overlay;
          #          pkgs = import nixpkgs {
          #            inherit system;
          #            config = { allowUnfree = true; };
          #            #overlays = [ overlay ];
          #          };
        in
        {
          "knoff@lapix" = home-manager.lib.homeManagerConfiguration {
            pkgs = nixpkgs.legacyPackages.x86_64-linux;
            modules = [ ./home/knoff/lapix.nix ];
            extraSpecialArgs = {
              inherit inputs;
              inherit outputs;
              inherit system;
              inherit nix-colors;
            };
          };
          "knoff@desktop" = home-manager.lib.homeManagerConfiguration {
            pkgs = nixpkgs.legacyPackages.x86_64-linux;
            modules = [ ./home/knoff/desktop.nix ];
            extraSpecialArgs = {
              inherit inputs;
              inherit outputs;
              inherit system;
              inherit nix-colors;
            };
          };
        };
    };
}
