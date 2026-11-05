# Homebrew environment
if [[ -d /home/linuxbrew/.linuxbrew/bin ]]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
elif [[ -d /opt/homebrew/bin ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi
