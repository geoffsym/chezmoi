# Chezmoi Dotfiles

A portable collection of my personal configuration files and templates, managed with [Chezmoi](https://www.chezmoi.io/).

## Machine Flags

On initialization (`chezmoi init`), `.chezmoi.toml.tmpl` prompts for two boolean flags and stores them in `~/.config/chezmoi/chezmoi.toml` under `[data]`:

- **`desktop`** (`true` / `false`): Whether the machine has a graphical desktop environment. When `false`, desktop configurations (`konsolerc`, Konsole profiles) are ignored via `.chezmoiignore`.
- **`work`** (`true` / `false`): Whether the machine is a corporate work environment. When `true`, templates use work-specific values (e.g., work Git email) and omit homelab-only endpoints (`*.local.geoff.app`).

## Dependencies

Upon running `chezmoi apply`, an included verification script checks for recommended interactive CLI utilities:

| Tool | Purpose | Homebrew Formula | Arch Package |
| :--- | :--- | :--- | :--- |
| **`zsh`** | Default interactive shell | `zsh` | `zsh` |
| **`antidote`** | Zsh plugin manager | `antidote` | `zsh-antidote` (AUR) |
| **`chezmoi`** | Dotfile manager | `chezmoi` | `chezmoi` |
| **`eza`** | Modern `ls` replacement | `eza` | `eza` |
| **`fzf`** | Fuzzy finder | `fzf` | `fzf` |
| **`ripgrep`** | Fast recursive regex search (`rg`) | `ripgrep` | `ripgrep` |
| **`bat`** | Syntax-highlighting cat/pager | `bat` | `bat` |
| **`fd`** | Intuitive file search | `fd` | `fd` |
| **`neovim`** | Modal text editor (`nvim`) | `neovim` | `neovim` |
| **`fastfetch`** | System information fetcher | `fastfetch` | `fastfetch` |
| **`shpool`** | Shell session persistence daemon | `shpool` | `shpool` (AUR) |
| **`firacode-nerd`** | Monospace terminal font (`desktop=true`) | *(Manual on Linux)* | `ttf-firacode-nerd` |

### Quick Install One-Liners

**Debian-Based Distros (Ubuntu, Debian, WSL):**
```bash
sudo apt update && sudo apt install zsh
brew install chezmoi eza fzf ripgrep bat fd neovim fastfetch antidote shpool
```

**Arch-Based Distros (Pacman + Paru):**
```bash
sudo pacman -S zsh chezmoi eza fzf ripgrep bat fd neovim fastfetch
paru -S zsh-antidote shpool
```

**Desktop Packages (`desktop=true` on Arch):**
```bash
sudo pacman -S ttf-firacode-nerd
```

## Quick Start

### Work Laptop / WSL Bootstrap
From an external network using the public GitHub push mirror:
```bash
chezmoi init --apply https://github.com/geoffsym/chezmoi.git
# Prompts:
#   desktop: false
#   work: true
```
Or unattended:
```bash
chezmoi init --apply --promptBool "desktop=false,work=true" https://github.com/geoffsym/chezmoi.git
```

### Homelab Interactive Bootstrap
On the local network:
```bash
chezmoi init --apply ssh://gitea@git.local.geoff.app:2222/geoff/chezmoi.git
```

### Unattended Homelab Bootstrap (`lab-ansible`)
```bash
chezmoi init --apply --promptBool "desktop=false,work=false" https://git.local.geoff.app/geoff/chezmoi.git
```

## Common Commands

| Action | Command |
| :--- | :--- |
| Add a new file or directory | `chezmoi add ~/.config/<tool>` |
| Add a file as a template | `chezmoi add --template <path>` |
| Edit a tracked file & apply | `chezmoi edit --apply <path>` |
| Sync local edits back into Chezmoi | `chezmoi re-add` |
| Preview pending changes | `chezmoi diff` |
| Apply changes to `$HOME` | `chezmoi apply` |
| Pull latest from Git & apply | `chezmoi update` |
| Open a shell in the Chezmoi repo | `chezmoi cd` |
