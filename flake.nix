{
  description = "lowfat config";

  nixConfig = {
    # This allows the use of user built binaries? 
    #extra-substituters = [
    #  "https://nix-community.cachix.org"
    #];
    #extra-trusted-public-keys = [
    #  "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    #];
    # ibelive this should work
    extra-substituters = ["https://hyprland.cachix.org"];
    extra-trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };
  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    unstable-pkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix.url = "github:Mic92/sops-nix";

    prismlauncher.url = "github:PrismLauncher/PrismLauncher";

    hyprland.url = "github:hyprwm/hyprland/v0.17.0beta";
    #hyprwm-contrib.url = "github:hyprwm/contrib";

    # Home manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    hardware.url = "github:nixos/nixos-hardware";
    #nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs = inputs@ { 
    self, 
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
        [ ./systems/lapix ]; # Laptop-Nix > Lapix
      };
      desktop = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = 
        [ ./systems/desktop ]; # Desktop
      };
    };

    # Available through 'home-manager --flake .#your-username@your-hostname'
    homeConfigurations = 
    let
      # Pass the unstable package set in as an additional import
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      unstable = import unstable-pkgs 
      { 
        inherit system;
        config = {
          allowUnfree = true;
        };
      }; # legacyPackages.${system};

    in
    {
      "knoff@lapix" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit inputs; };
        modules = [ ./home/knoff/lapix.nix ]; 
        extraSpecialArgs = {
          inherit unstable;
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


    };

  };
}
