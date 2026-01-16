{
  description = "Andy's modular dotfiles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ nixpkgs, home-manager, flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" ];

      perSystem = { config, pkgs, system, ... }: {
        # You can add system packages or formatter configurations here
      };

      flake = {
        homeConfigurations."andy" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages."x86_64-linux";
          modules = [
            ./nix/modules/home
            {
              home = {
                username = "andy";
                homeDirectory = "/home/andy";
              };
            }
          ];
        };
      };
    };
}
