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

    # Modern development tools
    tokei         # Count lines of code
    procs         # Alternative to ps
    bottom        # Alternative to htop (btm)
    delta         # Better git diff
    diff-so-fancy # Even better git diff
    lazygit       # Git TUI
    gh            # GitHub CLI
    du-dust       # Visualize disk usage (dust)
    ripgrep-all   # Search through PDF, zip, etc. (rga)
  ];
}
