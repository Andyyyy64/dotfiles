{ config, pkgs, ... }:

{
  # Zsh settings
  home.file.".zshrc".source = ../../../zsh/.zshrc;
  home.file.".zshenv".source = ../../../zsh/.zshenv;

  programs.zsh = {
    enable = true;
    initExtra = ''
      # Write additional zsh settings here if any
    '';
  };

  # Common aliases
  home.shellAliases = {
    ls = "eza";
    ll = "eza -l";
    la = "eza -la";
    cat = "bat";
    grep = "rg";
    diff = "delta";
    ps = "procs";
    htop = "btm"; # Prefer using bottom (btm)
  };
}
