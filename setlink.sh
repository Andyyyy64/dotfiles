#!/bin/bash
# Script to create symbolic links

dotfiles_folder="${HOME}/dotfiles/"
config_folder="${HOME}/.config"
home_folder="${HOME}"

main () {
    printf "Creating symbolic links for dotfiles...\n"

    # dotfiles for the .config folder
    declare -a config_files=("emacs" "i3" "picom" "polybar")

    # dotfiles for the home folder
    declare -a home_files=("zsh/.zshrc" "zsh/.zshenv" ".doom.d")

    # Process all files in the .config folder
    for file in "${config_files[@]}"; do
        create_symlink "dotfiles/${file}" "${config_folder}"
    done

    for file in "${home_files[@]}"; do
        create_symlink "dotfiles/${file}" "${home_folder}"
    done



    printf "All symbolic links have been created.\n"
}

create_symlink () {
    local src_file="$HOME/$1" # Add path to the source file
    local target_file="${2}/$(basename $1)" # Destination file based on basename of the source file

    # Check if the target link already exists
    if [[ -f "$target_file" ]] || [[ -d "$target_file" ]]; then
        printf "Existing configuration found for $(basename $1).\n"
        printf "Do you want to overwrite it? [yes]/[no]: "
        read overwrite
        if [[ $overwrite == "yes" ]]; then
            ln -sfn "$src_file" "$target_file"
            printf "Symlink for $(basename $1) successfully created.\n"
        else
            printf "Skipping $(basename $1).\n"
        fi
    else
        ln -s "$src_file" "$target_file"
        printf "Symlink for $(basename $1) successfully created.\n"
    fi
}

main "$@"
