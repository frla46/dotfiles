.DEFAULT_GOAL = help

MAKEFILE_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
DOTFILES_DIR := $(abspath $(dir $(MAKEFILE_PATH)))
HOME_SRC_DIR := $(DOTFILES_DIR)/home
YAY := yay -S --needed --noconfirm

all: yay install-minimal install-core install-extra ## deploy dotfiles
install-minimal: git neovim wezterm zsh ## install minimal packages
install-core: at atool bat bottom clipcat conceal cronie discord docker dunst dust eza fcitx5 fd github-cli hackgen i3 jq lazygit libreoffice maim megasync mimeapps mpv noto-fonts nsxiv obsidian playerctl procs pulsemixer redshift restic ripgrep rofi steam thunar ufw unclutter uv vim vnstat xclip xinit yazi zathura zen-browser zoxide ## install packages
install-extra: ani-cli aria2 chromium downgrade genymotion ghidra gimp netcat hugo lostfiles nord-theme osu-lazer pfetch pwndbg radare2 rust vdhcoapp virtualbox yt-dlp ## install extra packages (long build time or occationally used)
system-configs: locale systemd resolved ## set configs

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
	$(YAY) $@ betterdiscordctl
	status_output="$$(betterdiscordctl status 2>/dev/null || true)"; \
	if echo "$$status_output" | grep -q 'Discord "index.js" injected: no'; then \
		betterdiscordctl install; \
	else \
		betterdiscordctl reinstall; \
	fi
	mkdir -p ${HOME}/.config/BetterDiscord/data/stable/
	ln -vsfn ${HOME_SRC_DIR}/.config/BetterDiscord/data/stable/custom.css ${HOME}/.config/BetterDiscord/data/stable/custom.css

docker:
	$(YAY) $@ $@-compose lazydocker
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

genymotion:
	$(YAY) $@

ghidra:
	$(YAY) $@

gimp:
	$(YAY) $@

git:
	$(YAY) $@
	ln -vsfn ${HOME_SRC_DIR}/.gitconfig ${HOME}/.gitconfig

github-cli:
	$(YAY) $@

hackgen:
	$(YAY) ttf-$@

help: ## show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
	| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

hugo:
	$(YAY) $@

i3:
	rm -rf ${HOME}/.config/$@
	ln -vsfn ${HOME_SRC_DIR}/.config/$@ ${HOME}/.config/$@
	rm -rf ${HOME}/.config/$@status
	ln -vsfn ${HOME_SRC_DIR}/.config/$@status ${HOME}/.config/$@status

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

maim:
	$(YAY) $@

megasync:
	$(YAY) $@-bin

mimeapps:
	ln -vsfn ${HOME_SRC_DIR}/.config/mimeapps.list ${HOME}/.config/mimeapps.list

mpv:
	$(YAY) $@-mpris
	rm -rf ${HOME}/.config/$@
	ln -vsfn ${HOME_SRC_DIR}/.config/$@ ${HOME}/.config/$@

neovim:
	$(YAY) $@ npm
	rm -rf ${HOME}/.config/nvim
	ln -vsfn ${HOME_SRC_DIR}/.config/nvim ${HOME}/.config/nvim

netcat:
	$(YAY) gnu-$@

nord-theme:
	$(YAY) $@ nordic-darker-theme nordzy-cursors nordzy-icon-theme fcitx5-nord

noto-fonts:
	$(YAY) $@-cjk $@-emoji $@-extra

nsxiv:
	$(YAY) $@
	rm -rf ${HOME}/.config/$@
	ln -vsfn ${HOME_SRC_DIR}/.config/$@ ${HOME}/.config/$@

obsidian:
	$(YAY) $@

osu-lazer:
	$(YAY) $@-bin

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

redshift:
	$(YAY) $@

resolved:
	sudo systemctl disable --now systemd-resolved
	@if [ -L /etc/resolv.conf ] && [ ! -e /etc/resolv.conf ]; then \
		sudo rm -f /etc/resolv.conf; \
	fi
	echo 'nameserver 1.1.1.1' | sudo tee /etc/resolv.conf

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

steam:
	$(YAY) $@ lib32-systemd

systemd:
	sudo sed -i 's/#SystemMaxUse=/SystemMaxUse=50M/' /etc/systemd/journald.conf
	sudo systemctl restart systemd-journald

thunar:
	$(YAY) $@

ufw:
	$(YAY) $@
	sudo ufw default deny
	sudo ufw enable
	sudo systemctl enable --now ufw

unclutter:
	$(YAY) $@

uv:
	$(YAY) $@

vdhcoapp:
	$(YAY) $@-bin

vim:
	$(YAY) $@

virtualbox:
	$(YAY) $@

vnstat:
	$(YAY) $@

wezterm:
	$(YAY) $@
	rm -rf ${HOME}/.config/$@
	ln -vsfn ${HOME_SRC_DIR}/.config/$@ ${HOME}/.config/$@

xclip:
	$(YAY) $@

xinit:
	ln -vsfn ${HOME_SRC_DIR}/.xinitrc ${HOME}/.xinitrc
	ln -vsfn ${HOME_SRC_DIR}/.Xresources ${HOME}/.Xresources

yay: ## install yay
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

yazi:
	$(YAY) $@ ffmpeg 7zip jq poppler fd ripgrep fzf zoxide imagemagick xclip
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

zsh:
	$(YAY) $@ sheldon starship
	chsh -s $(shell which zsh)
	ln -vsfn ${HOME_SRC_DIR}/.zshenv ${HOME}/.zshenv
	rm -rf ${HOME}/.config/$@
	ln -vsfn ${HOME_SRC_DIR}/.config/$@ ${HOME}/.config/$@
	rm -rf ${HOME}/.config/sheldon
	ln -vsfn ${HOME_SRC_DIR}/.config/sheldon ${HOME}/.config/sheldon
	ln -vsfn ${HOME_SRC_DIR}/.config/starship.toml ${HOME}/.config/starship.toml

