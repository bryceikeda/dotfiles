[[ -n $SSH_CONNECTION ]] && ZSH_THEME="custom-hostname" || ZSH_THEME="custom"
DISABLE_AUTO_UPDATE="true"
ENABLE_CORRECTION="false"
HYPHEN_INSENSITIVE="true"

plugins=(
    colored-man-pages
    command-not-found
    extract
    fzf
    git
    z
    zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh
source $HOME/.aliases.zsh
source $HOME/.functions.zsh
if [ -f $HOME/.zshrc_local ]; then
    source $HOME/.zshrc_local
fi
