{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    # List of extensions
    # Note: Cursor-specific extensions or some extensions may not be available in Nixpkgs
    extensions = with pkgs.vscode-extensions; [
      jnoortheen.nix-ide
      dracula-theme.theme-dracula
      tuttieee.emacs-mcx
      vscodevim.vim
      ms-ceintl.vscode-language-pack-ja
      ms-python.python
      ms-python.debugpy
      ms-azuretools.vscode-docker
      ms-vscode.cpptools
      golang.go
      eamodio.gitlens
      editorconfig.editorconfig
      hashicorp.terraform
      redhat.vscode-yaml
      ms-toolsai.jupyter
      bradlc.vscode-tailwindcss
      davidanson.vscode-markdownlint
    ];
    userSettings = {
      "editor.fontSize" = 14;
      "workbench.colorTheme" = "Default Dark Modern";
      "editor.inlineSuggest.enabled" = true;
      "editor.formatOnSave" = true;
      "editor.lineNumbers" = "on";
      "files.autoSave" = "afterDelay";
    };
  };
}
