{ config, pkgs, ... }:

{
  # Zsh settings
  home.file.".zshrc".source = ../../../zsh/.zshrc;
  home.file.".zshenv".source = ../../../zsh/.zshenv;

  programs.zsh = {
    enable = true;
    # Manage completion and highlighting via Nix
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    initExtra = ''
      # Additional zsh settings
    '';
  };

  # Modern tool enablement and shell integration
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true; # Enhance integration with Nix
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
    htop = "btm";
    cd = "z"; # Use zoxide as cd
    du = "dust";
  };
}
