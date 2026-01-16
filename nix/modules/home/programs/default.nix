{ config, pkgs, ... }:

{
  imports = [
    ./vscode
  ];

  # Symlink WezTerm configuration files
  home.file.".config/wezterm" = {
    source = ../../../../wezterm;
    recursive = true;
  };
}
