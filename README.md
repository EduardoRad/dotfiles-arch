# dotfiles-arch

My personal config files, stow-style: each top-level folder mirrors the
path it belongs at under `$HOME`.

```
dotfiles-arch/
├── bash/.bashrc
├── nvim/.config/nvim/
├── niri/.config/niri/
├── waybar/.config/waybar/
└── ghostty/.config/ghostty/
```

## Setup on a new machine

Clone the repo, then symlink each config into place:

```bash
git clone git@github.com:EduardoRad/dotfiles-arch.git ~/dotfiles-arch
cd ~/dotfiles-arch

ln -sf ~/dotfiles-arch/bash/.bashrc ~/.bashrc
mkdir -p ~/.config
ln -sf ~/dotfiles-arch/nvim/.config/nvim ~/.config/nvim
ln -sf ~/dotfiles-arch/niri/.config/niri ~/.config/niri
ln -sf ~/dotfiles-arch/waybar/.config/waybar ~/.config/waybar
ln -sf ~/dotfiles-arch/ghostty/.config/ghostty ~/.config/ghostty
```

## Adding a new config

1. `mkdir -p dotfiles-arch/<app>/<path mirroring $HOME>`
2. `mv ~/<path to config> dotfiles-arch/<app>/<same path>`
3. `ln -s ~/dotfiles-arch/<app>/<path> ~/<original path>`
4. `git add`, commit, push.
