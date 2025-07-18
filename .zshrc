
ZINIT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git"
if [[ ! -d $ZINIT_HOME ]]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "$ZINIT_HOME/zinit.zsh"

HISTFILE=~/.zsh_history
HISTSIZE=3000
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

autoload -Uz compinit
compinit
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # Case insensitive
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"   # Colorize completion


autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '(%F{red}%B%b%f %%b)'
setopt PROMPT_SUBST
PROMPT='%F{red}󰣇 %f %F{blue}%n%B%f [%F{red}%b%.%B%f] %F{red}►%b%f '

zinit light zdharma-continuum/fast-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions

eval $(thefuck --alias)
alias py="python"
alias bruh="fastfetch"
alias ff="fastfetch"
alias yo="cd ~/Documents/yes"
bindkey '^[[3~' delete-char # del
bindkey "^[[1;5D" backward-word # ctrl+left
bindkey "^[[1;5C" forward-word # ctrl+right
bindkey "^[[3;5~" kill-word # ctrl+del
bindkey "^H" backward-kill-word # ctrl+backspace

export PATH=$HOME/.local/bin:$PATH
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"

export PATH=$PATH:/home/br0wot/.spicetify
