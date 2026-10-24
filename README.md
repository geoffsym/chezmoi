# Chezmoi Dotfiles

A portable collection of my personal configuration files and templates, managed with [Chezmoi](https://www.chezmoi.io/).

## Machine Capabilities

On initialization (`chezmoi init`), `.chezmoi.toml.tmpl` prompts for two boolean flags and stores them in `~/.config/chezmoi/chezmoi.toml` under `[data]`:

- **`desktop`** (`true` / `false`): Whether the machine has a graphical desktop environment. When `false`, desktop and gaming configurations (`gamemode`, `MangoHud`, etc.) are ignored via `.chezmoiignore`.
- **`local`** (`true` / `false`): Whether the machine can reach `*.local.geoff.app` (directly on the homelab network or via VPN). When `false`, templates omit local-only endpoints and use external configurations.

## Quick Start

### Interactive Bootstrap
On the local network:
```bash
chezmoi init --apply ssh://gitea@git.local.geoff.app:2222/geoff/chezmoi.git
```

From an external network (once migrated to public Forgejo at `git.geoff.app`):
```bash
chezmoi init --apply https://git.geoff.app/geoff/chezmoi.git
```

### Unattended Bootstrap (`lab-ansible`)
```bash
chezmoi init --apply --promptBool "desktop=false,local=true" https://git.local.geoff.app/geoff/chezmoi.git
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
