# --- Aliases ---
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias wget='wget -c'

# Fallback aliases if only distro-renamed binaries exist
command -v bat &>/dev/null || { command -v batcat &>/dev/null && alias bat=batcat; }
command -v fd &>/dev/null || { command -v fdfind &>/dev/null && alias fd=fdfind; }

# Directory listings with eza (conditional on NERD_FONT)
if [[ -n "$NERD_FONT" ]]; then
  alias ls='eza -al --color=always --group-directories-first --icons'
  alias la='eza -a --color=always --group-directories-first --icons'
  alias ll='eza -l --color=always --group-directories-first --icons'
  alias lt='eza -aT --color=always --group-directories-first --icons'
else
  alias ls='eza -al --color=always --group-directories-first'
  alias la='eza -a --color=always --group-directories-first'
  alias ll='eza -l --color=always --group-directories-first'
  alias lt='eza -aT --color=always --group-directories-first'
fi

# Run previous command with sudo or prefix command with sudo
function please() {
  if [[ $# -eq 0 ]]; then
    eval sudo $(fc -ln -1)
  else
    sudo "$@"
  fi
}
alias pls=please
alias plz=please
