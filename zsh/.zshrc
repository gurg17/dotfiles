
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

eval "$(starship init zsh)"
export STARSHIP_CONFIG=~/.config/starship/starship.toml

export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

alias bbic="brew update &&\
    brew bundle install --cleanup --file=~/.config/brew/Brewfile &&\
    brew upgrade"

alias cl='clear'

# Git
alias gc="git commit -m"
alias gca="git commit -a -m"
alias gp="git push origin HEAD"
alias gpu="git pull origin"
alias gst="git status"
alias glog="git log --graph --topo-order --pretty='%w(100,0,6)%C(yellow)%h%C(bold)%C(black)%d %C(cyan)%ar %C(green)%an%n%C(bold)%C(white)%s %N' --abbrev-commit"
alias gdiff="git diff"
alias gco="git checkout"
alias gb='git branch'
alias gba='git branch -a'
alias gadd='git add'
alias ga='git add -p'
alias gcoall='git checkout -- .'
alias gr='git remote'
alias gre='git reset'

bindkey jj vi-cmd-mode

