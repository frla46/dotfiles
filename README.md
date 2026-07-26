# dotfiles

Personal dotfiles for an Arch Linux desktop.

![image](./misc/img/20240610205751.png)

## Components

- os: arch linux
- wm: i3-wm
  - bar: i3blocks
- terminal: wezterm
- shell: zsh
  - plugin manager: sheldon
  - prompt: starship
- editor: neovim with lazyvim
- launcher: rofi
- file manager: yazi
- image viewer: imv
- video player: mpv

## Setup

After installing Arch Linux with archinstall:

```sh
make yay
make install
```

Use `make unlock` to unlock encrypted files and `make help` to list targets.
