{ pkgs, ... }:

{
  # Packages to be installed commonly
  home.packages = with pkgs; [
    neofetch
    git
    ripgrep
    fd
    htop
    fzf
    bat
    eza
    ghq
    jq

    # Modern tools for better development
    tokei # Count lines of code
    procs # Alternative to ps
    bottom # Alternative to htop
    delta # Make git diff easier to read
    diff-so-fancy # Make diff even easier to read
  ];
}
