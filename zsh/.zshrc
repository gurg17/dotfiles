source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh

eval "$(starship init zsh)"
export STARSHIP_CONFIG=~/.config/starship/starship.toml

export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

alias bbic="brew update &&\
    brew bundle install --cleanup --file=~/.config/brew/Brewfile &&\
    brew upgrade"

alias cl='clear'
alias ff='fastfetch'
alias x='exit'

#NPM
alias nrd='npm run dev'
alias nrs='npm run storybook'
alias nrb='npm run build'

#DIR
alias sz="source ~/.zshrc"
alias nv='nvim'
alias nvh="nv ."
alias nvc='nv ~/.config'

# RTL
alias gtui='cd ~/projects/ui-components-videoland/'
alias gtlp='cd ~/projects/landing-frontend/'
alias gtbe='cd ~/projects/cc-backend-headless-cms/'
alias nulp="gtlp && npm install @rtl_nl/ui-components-videoland"

# Git
alias gc="git commit -m"
alias gca="git commit -a -m"
alias gp="git push origin HEAD"
alias gpo="git pull origin --no-rebase"
alias gs="git status"
alias glog="git log --graph --topo-order --pretty='%w(100,0,6)%C(yellow)%h%C(bold)%C(black)%d %C(cyan)%ar %C(green)%an%n%C(bold)%C(white)%s %N' --abbrev-commit"
alias gd="git diff"
alias gco="git checkout"
alias gb='git branch'
alias gba='git branch -a'
alias ga='git add .'
alias gr='git reset'

bindkey jj vi-cmd-mode
ff

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
