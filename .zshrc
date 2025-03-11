
ZINIT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git"
if [[ ! -d $ZINIT_HOME ]]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "$ZINIT_HOME/zinit.zsh"

zinit light zdharma-continuum/fast-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions

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

autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '(%F{red}%B%b%f %%b)'
setopt PROMPT_SUBST
PROMPT='%B %F{red}%b%f %F{blue}%n%B%f [%F{red}%b%.%B%f] %F{yellow}►%b%f '
# PROMPT='%B%F{#5044ad}%1"Nightfire:%f %F{white}%1~%f%b:${vcs_info_msg_0_}%B%%%b '

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' list-colors '${(s.:.)LS_COLORS}'
eval $(thefuck --alias)
alias ls='ls --color=auto'
alias py="python"
