.DEFAULT_GOAL = help

YAY := yay -S --needed --noconfirm

help: ## show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
	| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

link: ## set symlink dotfiles
	$(YAY) stow
	stow -Rv -t ~ dotfiles

allupdate: update pipupdate ## update all

update: ## update archlinux packages
	yay --needed --noconfirm

pipupdate: ## update python packages
	pip list --user | cut -d" " -f 1 | tail -n +3 | xargs pip install -U --user

test: docker ## test Makefile
	docker build -t dotfiles ${PWD}
	docker run -it --name dotfiles_test -d dotfiles:latest /bin/bash

wezterm: lf
	$(YAY) $@ kitty

at:
	$(YAY) $@
	sudo systemctl --now enable atd

atool:
	$(YAY) $@
	$(YAY) zip unzip unrar

bat:
	$(YAY) $@

bottom:
	$(YAY) $@

chromium:
	$(YAY) $@

code:
	$(YAY) $@

cronie:
	$(YAY) $@

discord:
	$(YAY) $@ betterdiscordctl
	betterdiscordctl install

docker:
	$(YAY) $@
	sudo usermod -aG $@ $(shell whoami)
	sudo systemctl --now enable docker

dunst:
	$(YAY) $@

dust:
	$(YAY) $@

fcitx5:
	$(YAY) $@-im $@-nord

git:
	$(YAY) $@ lazy$@

i3:
	$(YAY) $@-wm $@status $@lock-color

lf:
	$(YAY) $@ ctpv-git vimv-git ffmpegthumbnailer conceal-bin xclip chafa file

libreoffice:
	$(YAY) $@-still

maim:
	$(YAY) $@

megasync:
	$(YAY) $@-bin

mpv:
	$(YAY) $@ $@-mpris

gtk-theme:
	$(YAY) nordic-darker-theme nordzy-cursors nordzy-icon-theme fcitx5-nord

npm:
	$(YAY) $@

nvim: fd rg lf npm
	$(YAY) neovim

picom:
	$(YAY) $@

playerctl:
	$(YAY) $@

pqiv:
	$(YAY) $@

procs:
	$(YAY) $@

protonvpn-cli:
	$(YAY) $@

pulsemixer:
	$(YAY) $@

redshift:
	$(YAY) $@

restic:
	$(YAY) $@

ripgrep:
	$(YAY) $@

rofi:
	$(YAY) $@

rofi-greenclip: rofi
	$(YAY) $@

tree:
	$(YAY) $@

ttf-hackgen:
	$(YAY) $@

ufw:
	$(YAY) $@
	sudo ufw default deny
	sudo ufw enable


unclutter:
	$(YAY) $@

vivaldi:
	$(YAY) $@

yay: ## install yay
	mkdir -p ~/src/
	cd ~/src/ && git clone https://aur.archlinux.org/yay.git
	cd ~/src/yay/ && makepkg -si
	$(YAY) yay reflector
	sudo reflector -c jp -p https,http -l 5 --save /etc/pacman.d/mirrorlist
	sudo sed -i 's/#Color/Color/' /etc/pacman.conf
	sudo sed -i 's/#ParallelDownloads/ParallelDownloads/' /etc/pacman.conf

zathura:
	$(YAY) $@ $@-pdf-poppler

zsh:
	$(YAY) $@ sheldon zoxide fzf at eza fd

# config
nm_conf:
	echo -e '[main]\ndns=none' | sudo tee /etc/NetworkManager/NetworkManager.conf
	sudo systemctl restart NetworkManager

locale_conf:
	echo -e 'ja_JP.UTF-8 UTF-8\nen_US.UTF-8 UTF-8' | sudo tee /etc/locale.gen
	sudo locale-gen
	echo 'LANG=ja_JP.UTF-8' | sudo tee -a /etc/locale.conf

systemd_conf:
	sudo sed -i 's/#SystemMaxUse=/SystemMaxUse=50M/' /etc/systemd/journald.conf
	sudo systemctl restart systemd-journald

zsh_conf: zsh
	chsh -s $(shell which zsh)
