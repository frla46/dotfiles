.DEFAULT_GOAL = help

MAKEFILE_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
DOTFILES_DIR := $(abspath $(dir $(MAKEFILE_PATH)))
HOME_SRC_DIR := $(DOTFILES_DIR)/home
PACMAN := sudo pacman -S --needed --noconfirm
YAY := yay -S --needed --noconfirm

yay: ## install yay
	$(PACMAN) base-devel git
	@if ! which yay >/dev/null 2>&1; then \
		YAY_TEMP="$$(mktemp -d)"; \
		git clone --depth=1 https://aur.archlinux.org/yay.git "$$YAY_TEMP"; \
		cd "$$YAY_TEMP" && makepkg -si --noconfirm --needed; \
		rm -rf "$$YAY_TEMP"; \
	fi
	$(YAY) yay reflector
	sudo reflector -c jp -p https,http -l 5 --save /etc/pacman.d/mirrorlist
	sudo sed -i 's/#Color/Color/' /etc/pacman.conf
	sudo sed -i 's/#ParallelDownloads/ParallelDownloads/' /etc/pacman.conf

# main packages

install-minimal: git neovim wezterm zsh ## install minimal packages

git:
	$(YAY) $@ $@hub-cli
	ln -vsfn ${HOME_SRC_DIR}/.gitconfig ${HOME}/.gitconfig

neovim:
	$(YAY) $@ npm luarocks
	rm -rf ${HOME}/.config/nvim
	ln -vsfn ${HOME_SRC_DIR}/.config/nvim ${HOME}/.config/nvim

wezterm:
	$(YAY) $@
	rm -rf ${HOME}/.config/$@
	ln -vsfn ${HOME_SRC_DIR}/.config/$@ ${HOME}/.config/$@

zsh:
	$(YAY) $@ sheldon starship
	chsh -s $(shell which zsh)
	ln -vsfn ${HOME_SRC_DIR}/.zshenv ${HOME}/.zshenv
	rm -rf ${HOME}/.config/$@
	ln -vsfn ${HOME_SRC_DIR}/.config/$@ ${HOME}/.config/$@
	rm -rf ${HOME}/.config/sheldon
	ln -vsfn ${HOME_SRC_DIR}/.config/sheldon ${HOME}/.config/sheldon
	ln -vsfn ${HOME_SRC_DIR}/.config/starship.toml ${HOME}/.config/starship.toml

install: install-minimal at atool bat bottom clipcat codex conceal cronie discord docker dunst dust eza fcitx5 fd hackgen i3 imv jq lazygit libreoffice man maim markdown mimeapps mpv noto-fonts obsidian openvpn playerctl procs pulsemixer rclone redshift restic ripgrep rofi sfeed steam ufw uv xclip xinit yazi zathura zen-browser zoxide ## install packages

at:
	$(YAY) $@
	sudo systemctl enable --now atd

atool:
	$(YAY) $@ 7zip unrar unzip zip

bat:
	$(YAY) $@

bottom:
	$(YAY) $@

clipcat:
	$(YAY) $@
	rm -rf ${HOME}/.config/$@
	ln -vsfn ${HOME_SRC_DIR}/.config/$@ ${HOME}/.config/$@

codex:
	$(YAY) openai-$@

conceal:
	$(YAY) $@-bin

cronie:
	$(YAY) $@
	sudo systemctl enable --now cronie

discord:
	$(YAY) $@ better$@ctl noisetorch-bin
	mkdir -p ${HOME}/.config/BetterDiscord/data/stable/
	ln -vsfn ${HOME_SRC_DIR}/.config/BetterDiscord/data/stable/custom.css ${HOME}/.config/BetterDiscord/data/stable/custom.css

docker:
	$(YAY) $@ $@-compose lazy$@
	sudo usermod -aG docker $(shell whoami)
	sudo systemctl --now enable docker

dunst:
	$(YAY) $@
	rm -rf ${HOME}/.config/$@
	ln -vsfn ${HOME_SRC_DIR}/.config/$@ ${HOME}/.config/$@

dust:
	$(YAY) $@

eza:
	$(YAY) $@

fcitx5:
	$(YAY) $@-im $@-mozc

fd:
	$(YAY) $@
	ln -vsfn ${HOME_SRC_DIR}/.ignore ${HOME}/.ignore

flatpak:
	$(YAY) flatpak flatseal

hackgen:
	$(YAY) ttf-$@

hugo:
	$(YAY) $@

i3:
	$(YAY) $@-wm $@lock-color $@blocks feh
	rm -rf ${HOME}/.config/$@
	ln -vsfn ${HOME_SRC_DIR}/.config/$@ ${HOME}/.config/$@
	rm -rf ${HOME}/.config/$@blocks
	ln -vsfn ${HOME_SRC_DIR}/.config/$@blocks ${HOME}/.config/$@blocks

imv:
	$(YAY) $@
	rm -rf ${HOME}/.config/$@
	ln -vsfn ${HOME_SRC_DIR}/.config/$@ ${HOME}/.config/$@
	mkdir -p ${HOME}/.local/bin
	ln -vsfn ${HOME_SRC_DIR}/.config/$@/imv_rifle.sh ${HOME}/.local/bin/imv_rifle.sh

java:
	$(YAY) jre-openjdk

jq:
	$(YAY) $@

lazygit:
	$(YAY) $@
	rm -rf ${HOME}/.config/$@
	ln -vsfn ${HOME_SRC_DIR}/.config/$@ ${HOME}/.config/$@

libreoffice:
	$(YAY) $@-still-ja

lostfiles:
	$(YAY) $@

man:
	$(YAY) $@-db

maim:
	$(YAY) $@

markdown:
	$(YAY) $@lint-cli2 prettier

mimeapps:
	ln -vsfn ${HOME_SRC_DIR}/.config/mimeapps.list ${HOME}/.config/mimeapps.list

mpv:
	$(YAY) $@-mpris
	rm -rf ${HOME}/.config/$@
	ln -vsfn ${HOME_SRC_DIR}/.config/$@ ${HOME}/.config/$@

noto-fonts:
	$(YAY) $@-cjk $@-emoji $@-extra

obsidian:
	$(YAY) $@

openvpn:
	$(YAY) $@

playerctl:
	$(YAY) $@

procs:
	$(YAY) $@

pulsemixer:
	$(YAY) $@

rclone:
	$(YAY) $@
	rm -rf ${HOME}/.config/$@
	ln -vsfn ${HOME_SRC_DIR}/.config/$@ ${HOME}/.config/$@

redshift:
	$(YAY) $@

restic:
	$(YAY) $@ fuse2
	ln -vsfn ${HOME_SRC_DIR}/.resticignore ${HOME}/.resticignore

ripgrep:
	$(YAY) $@
	rm -rf ${HOME}/.config/$@
	ln -vsfn ${HOME_SRC_DIR}/.config/$@ ${HOME}/.config/$@

rofi:
	$(YAY) $@ $@-calc $@-emoji
	rm -rf ${HOME}/.config/$@
	ln -vsfn ${HOME_SRC_DIR}/.config/$@ ${HOME}/.config/$@

sfeed:
	$(YAY) $@
	rm -rf ${HOME}/.$@
	ln -vsfn ${HOME_SRC_DIR}/.$@ ${HOME}/.$@

steam: flatpak
	flatpak install flathub com.valvesoftware.Steam
	$(YAY) protonup-qt

ufw:
	$(YAY) $@
	sudo ufw default deny
	sudo ufw enable
	sudo systemctl enable --now ufw

uv:
	$(YAY) $@

xclip:
	$(YAY) $@

xinit:
	$(YAY) xorg-xset
	ln -vsfn ${HOME_SRC_DIR}/.xinitrc ${HOME}/.xinitrc
	ln -vsfn ${HOME_SRC_DIR}/.Xresources ${HOME}/.Xresources

yazi:
	$(YAY) $@ ffmpeg 7zip jq poppler fd ripgrep fzf zoxide imagemagick xclip
	rm -rf ${HOME}/.config/$@
	ln -vsfn ${HOME_SRC_DIR}/.config/$@ ${HOME}/.config/$@
	ya pkg upgrade

zathura:
	$(YAY) $@-pdf-poppler
	rm -rf ${HOME}/.config/$@
	ln -vsfn ${HOME_SRC_DIR}/.config/$@ ${HOME}/.config/$@

zen-browser:
	$(YAY) $@-bin

zoxide:
	$(YAY) $@

# extra packages

ani-cli:
	$(YAY) $@-git

aria2:
	$(YAY) $@ $@p

chromium:
	$(YAY) $@

downgrade:
	$(YAY) $@

freerdp:
	$(YAY) $@

gemini:
	$(YAY) $@-cli

ghidra:
	$(YAY) $@

gimp:
	$(YAY) $@

netcat:
	$(YAY) gnu-$@

nord-theme:
	$(YAY) $@ nordic-darker-theme nordzy-cursors nordzy-icon-theme fcitx5-nord
	gsettings set org.gnome.desktop.interface gtk-theme "Nordic"
	gsettings set org.gnome.desktop.wm.preferences theme "Nordic"
	gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

obs:
	$(YAY) $@-studio

osu:
	$(YAY) $@-lazer-bin

pfetch:
	$(YAY) $@-rs

pwndbg:
	$(YAY) $@

radare2:
	$(YAY) $@

rust:
	$(YAY) $@up $@-analyzer
	rustup default stable

thunar:
	$(YAY) $@

unclutter:
	$(YAY) $@-xfixes-git

virtualbox:
	$(YAY) $@

xclicker:
	$(YAY) $@

xdotool:
	$(YAY) $@

yt-dlp:
	$(YAY) $@

# system configs

zram-generator:
	$(YAY) $@
	echo "[zram0]" | sudo tee /etc/systemd/zram-generator.conf
	echo "zram-size = ram / 2" | sudo tee -a /etc/systemd/zram-generator.conf
	echo "compression-algorithm = zstd" | sudo tee -a /etc/systemd/zram-generator.conf

locale:
	echo -e 'ja_JP.UTF-8 UTF-8\nen_US.UTF-8 UTF-8' | sudo tee /etc/locale.gen
	sudo locale-gen
	echo 'LANG=ja_JP.UTF-8' | sudo tee -a /etc/locale.conf

resolved:
	sudo systemctl disable --now systemd-resolved
	@if [ -L /etc/resolv.conf ] && [ ! -e /etc/resolv.conf ]; then \
		sudo rm -f /etc/resolv.conf; \
	fi
	echo 'nameserver 1.1.1.1' | sudo tee /etc/resolv.conf

# utils

unlock: ## unlock encrypted files
	$(YAY) git-crypt
	git-crypt unlock

rclone_push: rclone ## backup to cloud
	$(YAY) $@
	rclone config reconnect gdrive:
	rclone sync ~/sync/ gdrive:sync --progress

rclone_pull: rclone ## download from cloud
	$(YAY) $@
	rclone config reconnect gdrive:
	rclone sync gdrive:sync ~/sync/ --progress

help: ## show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
	| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

