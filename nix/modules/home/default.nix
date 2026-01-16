{ config, pkgs, ... }:

{
  imports = [
    ./packages.nix
    ./shell
    ./programs
  ];

  # Enable home-manager
  programs.home-manager.enable = true;

  home.stateVersion = "24.11";
}
