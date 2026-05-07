.DEFAULT_GOAL = help

MAKEFILE_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
DOTFILES_DIR := $(abspath $(dir $(MAKEFILE_PATH)))
HOME_SRC_DIR := $(DOTFILES_DIR)/home
PACMAN := sudo pacman -S --needed --noconfirm
YAY := yay -S --needed --noconfirm

all: yay install-minimal install-core install-extra ## deploy dotfiles
install-minimal: git neovim wezterm zsh ## install minimal packages
install-core: at atool bat bottom clipcat conceal cronie discord docker dunst dust eza fcitx5 fd gammastep hackgen imv jq lazygit libreoffice man mimeapps mpv noto-fonts obsidian openvpn playerctl procs pulsemixer rclone restic ripgrep rofi sfeed steam sway thunar ufw uv vim wl-clipboard xinit yazi zathura zen-browser zoxide ## install packages
install-extra: ani-cli aria2 chromium downgrade freerdp genymotion ghidra gimp hugo lostfiles netcat nord-theme pfetch pwndbg radere2 rust virtualbox yt-dlp ## install extra packages (long build time or occationally used)
system-configs: locale zram-generator ## set system configs

ani-cli:
	$(YAY) $@

at:
	$(YAY) $@
	sudo systemctl enable --now atd

aria2:
	$(YAY) $@ $@p

atool:
	$(YAY) $@ 7zip unrar unzip zip

bat:
	$(YAY) $@

bottom:
	$(YAY) $@

chromium:
	$(YAY) $@

clipcat:
	$(YAY) $@
	rm -rf ${HOME}/.config/$@
	ln -vsfn ${HOME_SRC_DIR}/.config/$@ ${HOME}/.config/$@

conceal:
	$(YAY) $@-bin

cronie:
	$(YAY) $@
	sudo systemctl enable --now cronie

discord:
	$(YAY) $@ better$@ctl noisetorch
	status_output="$$(betterdiscordctl status 2>/dev/null || true)"; \
	if echo "$$status_output" | grep -q 'Discord "index.js" injected: no'; then \
		betterdiscordctl install; \
	fi
	mkdir -p ${HOME}/.config/BetterDiscord/data/stable/
	ln -vsfn ${HOME_SRC_DIR}/.config/BetterDiscord/data/stable/custom.css ${HOME}/.config/BetterDiscord/data/stable/custom.css

docker:
	$(YAY) $@ $@-compose lazy$@
	sudo usermod -aG docker $(shell whoami)
	sudo systemctl --now enable docker

downgrade:
	$(YAY) $@

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

freerdp:
	$(YAY) $@

gammastep:
	$(YAY) $@

genymotion:
	$(YAY) $@

ghidra:
	$(YAY) $@

gimp:
	$(YAY) $@

git:
	$(YAY) $@ $@hub-cli
	ln -vsfn ${HOME_SRC_DIR}/.gitconfig ${HOME}/.gitconfig

hackgen:
	$(YAY) ttf-$@

help: ## show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
	| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

hugo:
	$(YAY) $@

imv:
	$(YAY) $@
	rm -rf ${HOME}/.config/$@
	ln -vsfn ${HOME_SRC_DIR}/.config/$@ ${HOME}/.config/$@
	ln -vsfn ${HOME_SRC_DIR}/.config/$@/imv_rifle.sh ${HOME}/.local/bin/imv_rifle.sh

# i3:
# 	$(YAY) $@-wm $@blocks $@lock-color
# 	rm -rf ${HOME}/.config/$@
# 	ln -vsfn ${HOME_SRC_DIR}/.config/$@ ${HOME}/.config/$@
# 	rm -rf ${HOME}/.config/$@blocks
# 	ln -vsfn ${HOME_SRC_DIR}/.config/$@blocks ${HOME}/.config/$@blocks

jq:
	$(YAY) $@

lazygit:
	$(YAY) $@
	rm -rf ${HOME}/.config/$@
	ln -vsfn ${HOME_SRC_DIR}/.config/$@ ${HOME}/.config/$@

libreoffice:
	$(YAY) $@-still-ja

locale:
	echo -e 'ja_JP.UTF-8 UTF-8\nen_US.UTF-8 UTF-8' | sudo tee /etc/locale.gen
	sudo locale-gen
	echo 'LANG=ja_JP.UTF-8' | sudo tee -a /etc/locale.conf

lostfiles:
	$(YAY) $@

man:
	$(YAY) $@-db

# maim:
# 	$(YAY) $@

mimeapps:
	ln -vsfn ${HOME_SRC_DIR}/.config/mimeapps.list ${HOME}/.config/mimeapps.list

mpv:
	$(YAY) $@-mpris
	rm -rf ${HOME}/.config/$@
	ln -vsfn ${HOME_SRC_DIR}/.config/$@ ${HOME}/.config/$@

neovim:
	$(YAY) $@ npm luarocks
	rm -rf ${HOME}/.config/nvim
	ln -vsfn ${HOME_SRC_DIR}/.config/nvim ${HOME}/.config/nvim

netcat:
	$(YAY) gnu-$@

nord-theme:
	$(YAY) $@ nordic-darker-theme nordzy-cursors nordzy-icon-theme fcitx5-nord
	gsettings set org.gnome.desktop.interface gtk-theme "Nordic"
	gsettings set org.gnome.desktop.wm.preferences theme "Nordic"
	gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

noto-fonts:
	$(YAY) $@-cjk $@-emoji $@-extra

# nsxiv:
# 	$(YAY) $@
# 	rm -rf ${HOME}/.config/$@
# 	ln -vsfn ${HOME_SRC_DIR}/.config/$@ ${HOME}/.config/$@
# 	ln -vsfn ${HOME_SRC_DIR}/.config/$@/nsxiv_rifle.sh ${HOME}/.local/bin/nsxiv_rifle.sh

obsidian:
	$(YAY) $@

openvpn:
	$(YAY) $@

pfetch:
	$(YAY) $@

playerctl:
	$(YAY) $@

procs:
	$(YAY) $@

pulsemixer:
	$(YAY) $@

pwndbg:
	$(YAY) $@

radare2:
	$(YAY) $@

rclone:
	$(YAY) $@
	rm -rf ${HOME}/.config/$@
	ln -vsfn ${HOME_SRC_DIR}/.config/$@ ${HOME}/.config/$@

rclone_push: ## backup to cloud
	$(YAY) $@
	rclone sync ~/sync/ gdrive:sync --progress

rclone_pull: ## download from cloud
	$(YAY) $@
	rclone sync gdrive:sync ~/sync/ --progress

# redshift:
# 	$(YAY) $@

# resolved:
# 	sudo systemctl disable --now systemd-resolved
# 	@if [ -L /etc/resolv.conf ] && [ ! -e /etc/resolv.conf ]; then \
# 		sudo rm -f /etc/resolv.conf; \
# 	fi
# 	echo 'nameserver 1.1.1.1' | sudo tee /etc/resolv.conf

restic:
	$(YAY) $@
	ln -vsfn ${HOME_SRC_DIR}/.resticignore ${HOME}/.resticignore

ripgrep:
	$(YAY) $@
	rm -rf ${HOME}/.config/$@
	ln -vsfn ${HOME_SRC_DIR}/.config/$@ ${HOME}/.config/$@

rofi:
	$(YAY) $@ $@-calc $@-emoji
	rm -rf ${HOME}/.config/$@
	ln -vsfn ${HOME_SRC_DIR}/.config/$@ ${HOME}/.config/$@

rust:
	$(YAY) $@up $@-analyzer
	rustup default stable

sfeed:
	$(YAY) $@
	rm -rf ${HOME}/.$@
	ln -vsfn ${HOME_SRC_DIR}/.$@ ${HOME}/.$@

steam:
	sudo sed -i '/^#\[multilib\]/,/^#Include = \/etc\/pacman.d\/mirrorlist/ s/^#//' /etc/pacman.conf
	$(YAY) $@ lib32-systemd protonup-qt

sway:
	rm -rf ${HOME}/.config/$@
	ln -vsfn ${HOME_SRC_DIR}/.config/$@ ${HOME}/.config/$@
	rm -rf ${HOME}/.config/$@blocks
	ln -vsfn ${HOME_SRC_DIR}/.config/$@blocks ${HOME}/.config/$@blocks

thunar:
	$(YAY) $@

ufw:
	$(YAY) $@
	sudo ufw default deny
	sudo ufw enable
	sudo systemctl enable --now ufw

# unclutter:
# 	$(YAY) $@

unlock: ## unlock encrypted files
	$(YAY) git-crypt
	git-crypt unlock

uv:
	$(YAY) $@

vim:
	$(YAY) $@

virtualbox:
	$(YAY) $@

# vnstat:
# 	$(YAY) $@

wezterm:
	$(YAY) $@
	rm -rf ${HOME}/.config/$@
	ln -vsfn ${HOME_SRC_DIR}/.config/$@ ${HOME}/.config/$@

wl-clipboard:
	$(YAY) $@

# xclip:
# 	$(YAY) $@

xinit:
	ln -vsfn ${HOME_SRC_DIR}/.xinitrc ${HOME}/.xinitrc
	ln -vsfn ${HOME_SRC_DIR}/.Xresources ${HOME}/.Xresources

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
	# sudo sed -i 's/#ParallelDownloads/ParallelDownloads/' /etc/pacman.conf

yazi:
	$(YAY) $@ ffmpeg 7zip jq poppler fd ripgrep fzf zoxide imagemagick wl-clipboard
	rm -rf ${HOME}/.config/$@
	ln -vsfn ${HOME_SRC_DIR}/.config/$@ ${HOME}/.config/$@
	ya pkg upgrade

yt-dlp:
	$(YAY) $@

zathura:
	$(YAY) $@-pdf-poppler
	rm -rf ${HOME}/.config/$@
	ln -vsfn ${HOME_SRC_DIR}/.config/$@ ${HOME}/.config/$@

zen-browser:
	$(YAY) $@-bin

zoxide:
	$(YAY) $@

zram-generator:
	$(YAY) $@
	echo "[zram0]" | sudo tee /etc/systemd/zram-generator.conf
	echo "zram-size = ram / 2" | sudo tee -a /etc/systemd/zram-generator.conf
	echo "compression-algorithm = zstd" | sudo tee -a /etc/systemd/zram-generator.conf

zsh:
	$(YAY) $@ sheldon starship
	sudo chsh -s $(shell which zsh)
	ln -vsfn ${HOME_SRC_DIR}/.zshenv ${HOME}/.zshenv
	rm -rf ${HOME}/.config/$@
	ln -vsfn ${HOME_SRC_DIR}/.config/$@ ${HOME}/.config/$@
	rm -rf ${HOME}/.config/sheldon
	ln -vsfn ${HOME_SRC_DIR}/.config/sheldon ${HOME}/.config/sheldon
	ln -vsfn ${HOME_SRC_DIR}/.config/starship.toml ${HOME}/.config/starship.toml

