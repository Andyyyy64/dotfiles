{ config, pkgs, ... }:

{
  imports = [
    ./packages.nix
    ./shell
    ./programs
  ];

  # Manage home-manager itself
  programs.home-manager.enable = true;

  home.stateVersion = "24.11";
}
