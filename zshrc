#
#   _______ ______  ____  ___  ________  __  ______
#  / ___/ // / __ \/ __ \/ _ \/  _/ __ \/ / / / __/
# / /__/ _  / /_/ / /_/ / // // // /_/ / /_/ / _/
# \___/_//_/\____/\____/____/___/\___\_\____/___/
#
#                      .dotfiles
#

# ------------------------------------------------------------------------------
# History
# ------------------------------------------------------------------------------

HISTFILE="$HOME/.config/zsh/zsh_history"
HISTSIZE=8192
SAVEHIST=8129

setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_VERIFY
setopt EXTENDED_HISTORY


# ------------------------------------------------------------------------------
# Completion
# ------------------------------------------------------------------------------

autoload -Uz compinit

# Быстрый запуск compinit (пересобирает кэш .zcompdump не чаще одного раза в сутки)
if [[ -n $HOME/.config/zsh/zcompdump(#qN.m+1) ]]; then
    compinit -d "$HOME/.config/zsh/zcompdump"
else
    compinit -C -d "$HOME/.config/zsh/zcompdump"
fi

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'
#zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

setopt AUTO_MENU
setopt ALWAYS_TO_END


# ------------------------------------------------------------------------------
# Colors
# ------------------------------------------------------------------------------
autoload -Uz colors
colors


# ------------------------------------------------------------------------------
# Prompt
# ------------------------------------------------------------------------------

PROMPT='[%F{39}%~%f] '


# ------------------------------------------------------------------------------
# Aliases
# ------------------------------------------------------------------------------

# ls
alias l='ls -lhG'
alias la='ls -A'
alias ll='ls -lahGF'

# Homebrew
alias b='brew'
alias bi='brew install'
alias bic='brew install --cask'
alias bs='brew search'
alias bup='brew update && brew upgrade'
alias bcl='brew cleanup'

# Git
alias g='git'
alias ga='git add'
alias gc='git commit -m'
alias gp='git push'

# Other
alias c='clear'

# ------------------------------------------------------------------------------
# Plugins
# ------------------------------------------------------------------------------

# Подключение zsh-autosuggestions (подсказки на основе истории)
if [[ -f /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
  source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# Подключение zsh-syntax-highlighting (подсветка команд)
if [[ -f /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
  source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# ------------------------------------------------------------------------------
# Dotfiles
# ------------------------------------------------------------------------------

readonly DOTFILES="$HOME/Documents/Projects/dotfiles"

dotfiles() {
    case "$1" in
        push)
            cp ~/.zshrc "$DOTFILES/zshrc"
            echo "✓ ~/.zshrc → $DOTFILES"
            ;;

        pull)
            read '?Overwrite ~/.zshrc? [y/N] ' reply
            [[ $reply == [Yy] ]] || return

            cp "$DOTFILES/zshrc" ~/.zshrc
            echo "✓ $DOTFILES → ~/.zshrc"
            ;;

        edit)
            ${EDITOR:-vi} "~/.zshrc"
            ;;

        reload)
            source ~/.zshrc
            echo "✓ ~/.zshrc reloaded"
            ;;

        *)
            cat <<EOF
Usage:
  dotfiles push      Copy ~/.zshrc -> dotfiles
  dotfiles pull      Restore ~/.zshrc from dotfiles
  dotfiles edit      Edit dotfiles version
  dotfiles reload    Reload current shell

EOF
            ;;
    esac
}


# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/artem/.lmstudio/bin"
# End of LM Studio CLI section

