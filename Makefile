.DEFAULT_GOAL = help
# .PHONY = setup pkgs link conf

YAY = yay -S --needed --noconfirm

help: ## show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
	| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

all: minimal cui gui misc ## init all
minimal: yay alacritty fcitx5 git nvim zsh ## init minimal
cui: aria2 at atool bat bottom docker dust exa fd fzf jq lf procs protonvpn-cli rclone ripgrep trash-cli tree ttf-hackgen ufw zk zoxide systemd ## init cui
gui: chromium discord dunst i3 libreoffice maim mpv nord-theme picom playerctl pqiv pulsemixer redshift rofi rofi-greenclip unclutter zathura ## init gui
misc: link ## init misc
conf: systemd locale

alacritty: ## install alacritty
	$(YAY) $@

aria2: ## install aria2
	$(YAY) $@

at: ## install at
	$(YAY) $@

atool: ## install atool
	$(YAY) $@

bat: ## install bat
	$(YAY) $@

bottom: ## install bottom
	$(YAY) $@

chromium: ## install chromium
	$(YAY) $@

discord: ## install discord
	$(YAY) $@

docker: ## init docker
	$(YAY) $@ lazy$@
	sudo usermod -aG $@ ${USER}
	sudo systemctl --now enable docker

dunst: ## install dunst
	$(YAY) $@

dust: ## install dust
	$(YAY) $@

exa: ## install exa
	$(YAY) $@

fcitx5: ## init fcitx5
	$(YAY) $@-im

fd: ## install fd
	$(YAY) $@

fzf: ## install fzf
	$(YAY) $@

git: ## install git
	$(YAY) $@ lazy$@

i3: ## install i3
	# $(YAY) $@
	$(YAY) $@lock-color

jq: ## install jq
	$(YAY) $@

lf: ## install lf
	$(YAY) $@ ctpv-git vimv-git ffmpegthumbnailer

libreoffice: ## install libreoffice
	$(YAY) $@-still

locale: ## init locale
	echo -e 'ja_JP.UTF-8 UTF-8\nen_US.UTF-8 UTF-8' > /etc/locale.gen
	locale-gen
	echo 'LANG=ja_JP.UTF-8' > /etc/locale.conf

maim: ## install maim
	$(YAY) $@

mpv: ## install mpv
	$(YAY) $@ $@-mpris

nord-theme: ## install nord theme
	$(YAY) nordic-darker-theme nordzy-cursors fcitx5-nord

nvim: ## install nvim
	$(YAY) neovim

picom: ## install picom
	$(YAY) $@

playerctl: ## install playerctl
	$(YAY) $@

pqiv: ## install pqiv
	$(YAY) $@

procs: ## install procs
	$(YAY) $@

protonvpn-cli: ## install protonvpn-cli
	$(YAY) $@

pulsemixer: ## install pulsemixer
	$(YAY) $@

rclone: ## install rclone
	$(YAY) $@

redshift: ## install redshift
	$(YAY) $@

ripgrep: ## install ripgrep
	$(YAY) $@

rofi: ## install rofi
	$(YAY) $@

rofi-greenclip: ## install rofi-greenclip
	$(YAY) $@

stow: ## install stow
	$(YAY) $@

systemd: #config systemd
	sudo sed -i 's/#SystemMaxUse=/SystemMaxUse=50M' /etc/systemd/journald.conf
	sudo systemctl restart systemd-journald

trash-cli: ## install trash-cli
	$(YAY) $@

tree: ## install tree
	$(YAY) $@

ttf-hackgen: ## install ttf-hackgen
	$(YAY) $@

ufw: ## init ufw
	$(YAY) $@
	sudo ufw default deny
	sudo ufw enable

unclutter: ## install unclutter
	$(YAY) $@

vivaldi: ## install vivaldi
	$(YAY) $@

yay: ## install yay
	$(YAY) reflector
	sudo reflector -c jp -p https,rsync -f 5 --save /etc/pacman.d/mirrorlist
	sudo sed -i 's/#Color/Color/' /etc/pacman.conf
	sudo sed -i 's/#ParallelDownloads/ParallelDownloads/' /etc/pacman.conf
	mkdir -p ~/src/
	cd ~/src/ && git clone https://aur.archlinux.org/yay.git && cd yay/ && makepkg -si
	yay

zathura: ## install zathura
	$(YAY) $@

zk: ## install zk
	$(YAY) $@

zoxide: ## install zoxide
	$(YAY) $@

zsh: ## install zsh
	$(YAY) $@ $@-antidote
	chsh -s $(shell which zsh)

link: stow ## symlink dotfiles
	stow dotfiles

docker_image: docker ## build docker image for test
	docker build -t dotfiles ${PWD}

test: docker_image ## test Makefile
	docker run -it --name makefile_test -d dotfiles:latest /bin/bash

# # todo
# - set gtk-theme cursor-theme
# - browser config
# 	- chrome://flags/#enable-force-dark -> CIELAB based inversion
# 	- extentions:
# 		- bitwarden
# 		- Blocktube
# 		- BookmarkCleanUp
# 		- copyAllURLs
# 		- DuplicateTabCloser
# 		- Feedbro
# 		- Keepa
# 		- LINE
# 		- MALSync
# 		- uAutoPagerize
# 		- uBlacklist
# 		- ubo
# 		- videoSpeedController
# 		- vimiumC
# 		- pdfViewerForVimiumC
