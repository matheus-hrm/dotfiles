export SPACESHIP_PROMPT_ORDER=(
  time
  user
  dir
  git
  exec_time
  jobs
  line_sep
  char
)
export SPACESHIP_CHAR_SYMBOL="λ"
export SPACESHIP_CHAR_SUFFIX=" "
export SPACESHIP_PROMPT_ADD_NEWLINE=true
export POWERLEVEL9K_MODE="nerdfont-complete"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=8"  # Gray suggestion
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

[ -f /usr/share/autojump/autojump.zsh ] && source /usr/share/autojump/autojump.zsh
alias cat="batcat --theme=Catppuccin-mocha"
alias ..="cd .."
alias ...="cd ../.."
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="spaceship"

zstyle ':omz:update' mode disabled  # disable automatic updates

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh
export PATH="$PATH:/usr/local/bin"
export PATH="/opt/node-v22.14.0/bin:$PATH"
export PATH=$HOME/.local/bin:$PATH

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

[ -f "/home/mou/.ghcup/env" ] && . "/home/mou/.ghcup/env" # ghcup-envexport PATH=$HOME/.local/bin:$PATH
