source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh

eval "$(starship init zsh)"
export STARSHIP_CONFIG=~/.config/starship/starship.toml

export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

alias bbiu="brew update &&\
    brew bundle install --cleanup --file=~/.config/brew/Brewfile &&\
    brew upgrade"

alias cl='clear'
alias ff='fastfetch'
alias q='exit'

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
alias gpo="git pull origin --no-rebase"
alias glog="git log --graph --topo-order --pretty='%w(100,0,6)%C(yellow)%h%C(bold)%C(black)%d %C(cyan)%ar %C(green)%an%n%C(bold)%C(white)%s %N' --abbrev-commit"
export TMPDIR=$(getconf DARWIN_USER_TEMP_DIR)
alias lg="lazygit"
bindkey jj vi-cmd-mode
ff

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
export PATH="$HOME/.local/bin:$PATH"
