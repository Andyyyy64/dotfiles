{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    # List of extensions
    # Note: Cursor-specific extensions or some extensions may not be available in Nixpkgs
    extensions = with pkgs.vscode-extensions; [
      jnoortheen.nix-ide                  # Nix IDE
      dracula-theme.theme-dracula         # Dracula Theme
      tuttieee.emacs-mcx                  # Awesome Emacs Keymap
      vscodevim.vim                       # Vim emulation
      ms-ceintl.vscode-language-pack-ja   # Japanese Language Pack
      ms-python.python                    # Python support
      ms-python.debugpy                   # Python debugger
      ms-azuretools.vscode-docker         # Docker support
      ms-vscode.cpptools                  # C++ support
      golang.go                           # Go support
      eamodio.gitlens                     # Git insights
      editorconfig.editorconfig           # EditorConfig support
      hashicorp.terraform                 # Terraform support
      redhat.vscode-yaml                  # YAML support
      ms-toolsai.jupyter                  # Jupyter notebooks
      bradlc.vscode-tailwindcss           # Tailwind CSS support
      davidanson.vscode-markdownlint       # Markdown linting
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
