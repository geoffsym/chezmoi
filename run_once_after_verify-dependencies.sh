#!/usr/bin/env bash
# Verifies presence of interactive CLI dependencies.
# Does NOT perform installations or modify system state.

set -u

missing=()

check_cmd() {
  local cmd="$1"
  local alt="${2:-}"
  if ! command -v "$cmd" &>/dev/null; then
    if [[ -n "$alt" ]] && command -v "$alt" &>/dev/null; then
      return 0
    fi
    missing+=("$cmd")
  fi
}

check_cmd zsh
check_cmd chezmoi
check_cmd eza
check_cmd fzf
check_cmd rg
check_cmd bat batcat
check_cmd fd fdfind
check_cmd nvim
check_cmd fastfetch

# Antidote plugin manager check
if [[ ! -f /usr/share/zsh-antidote/antidote.zsh && \
      ! -f /home/linuxbrew/.linuxbrew/opt/antidote/share/antidote/antidote.zsh && \
      ! -f "${XDG_DATA_HOME:-$HOME/.local/share}/antidote/antidote.zsh" ]]; then
  missing+=("antidote")
fi

if [ ${#missing[@]} -gt 0 ]; then
  echo ""
  echo "⚠️  [Chezmoi] Missing recommended interactive CLI tools:"
  for tool in "${missing[@]}"; do
    echo "   - $tool"
  done
  echo ""
  echo "👉 Arch Linux: sudo pacman -S ${missing[*]}"
  echo "👉 Other OS: brew install ${missing[*]}"
  echo ""
fi
