export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="random"

plugins=(git zsh-autosuggestions zsh-syntax-highlighting web-search)

source $ZSH/oh-my-zsh.sh

# alias's

alias c="clear"
alias l="ls -al"

alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

alias reload="source ~/.zshrc"

alias ipinfo="ipconfig | grep inet"

alias hsgrep="history | grep"

alias lsg="ls -al | grep"

alias cat="bat"

alias sshuniv="ssh s1300107@sshgate.u-aizu.ac.jp"

# emacs is you pet
alias compile_emacs_bitch='~/.config/emacs/bin/doom sync'

# are you sane?
alias rm="rm -i"

alias df="df -h"

alias grep="grep --color=auto"

alias cl="xclip -selection clipborad"

# functions

your_ass_stinks() {
        git add .
        git commit -m "fuck you"
        local branch=$(git symbolic-ref --short HEAD)
        git push origin $branch
}

just_extract_bitch() {
    if [ -f $1 ]; then
        case $1 in
        *.tar.bz2) tar xvjf $1 ;;
        *.tar.gz) tar xvzf $1 ;;
        *.bz2) bunzip2 $1 ;;
        *.rar) unrar x $1 ;;
        *.gz) gunzip $1 ;;
        *.tar) tar xvf $1 ;;
        *.tbz2) tar xvjf $1 ;;
        *.tgz) tar xvzf $1 ;;
        *.zip) unzip $1 ;;
        *.Z) uncompress $1 ;;
        *.7z) 7z x $1 ;;
        *) echo "tf is this?" ;;
        esac
    else
        echo "this is not a file dumass"
    fi
}

mcd() {
    mkdir -p "$1"
    cd "$1"
}

cd() {
    if [ -z "$1" ]; then
        builtin cd ~
    else
        builtin cd "$1" && ls -al
    fi
}

my_uptime() {
    uptime | awk -F'( |,|:)+' '{print $6,$7",",$8,"hours,",$9,"minutes"}'
}

search() {
    find . -name "$1" 2>/dev/null
}

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
. "$HOME/.cargo/env"
