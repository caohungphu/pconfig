ZSH_THEME="powerlevel10k/powerlevel10k"

export LANG=en_US.UTF-8
export LC_PAPER=en_US.utf8

plugins=(
    git
    pyenv
    virtualenv
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-history-substring-search
    zsh-bat
)

bindkey '^ ' autosuggest-accept
