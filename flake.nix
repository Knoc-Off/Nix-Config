{
  description = "lowfat config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    unstable-pkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    devenv.url = "github:cachix/devenv/v0.5";
    #nur-pkgs.url = "github:nix-community/NUR";


    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix.url = "github:Mic92/sops-nix";

    prismlauncher.url = "github:PrismLauncher/PrismLauncher";

    hyprland.url = "github:hyprwm/hyprland/v0.17.0beta";
    hyprwm-contrib.url = "github:hyprwm/contrib";

    # Home manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    hardware.url = "github:nixos/nixos-hardware";
    nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs = { self, nixpkgs, unstable-pkgs, home-manager, ... }@inputs: 
  {
    nixosConfigurations = {
      knoff = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = 
        [ 
          ./systems/lapix # lenovo thinkpad x1 6th gen
        ];
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
        #pkgs = nixpkgs.legacyPackages.x86_64-linux;
        inherit pkgs;
        extraSpecialArgs = { inherit inputs; };
        modules = [ ./home/knoff/home.nix ]; 
        extraSpecialArgs = {
          inherit unstable;
        };
      };
    };

  };
}
