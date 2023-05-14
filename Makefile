.DEFAULT_GOAL = help
# .PHONY = setup pkgs link conf

YAY = yay -S --needed --noconfirm

help: ## show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
	| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

# make yay
# cd yay/ && makepkg -si
# yay

all: minimal cui gui misc ## init all
minimal: yay alacritty fcitx5 git nvim zsh ## init minimal
cui: aria2 at atool bat bottom docker dust exa fd fzf jq lf procs protonvpn-cli rclone ripgrep trash-cli tree ttf-hackgen ufw zk zoxide ## init cui
gui: chromium discord dunst i3 libreoffice maim mpv nord-theme picom playerctl pqiv pulsemixer redshift rofi rofi-greenclip unclutter zathura ## init gui
misc: link systemd ## init misc

alacritty:
	$(YAY) $@

aria2:
	$(YAY) $@

at:
	$(YAY) $@

atool:
	$(YAY) $@

bat:
	$(YAY) $@

bottom:
	$(YAY) $@

chromium:
	$(YAY) $@

discord:
	$(YAY) $@

docker:
	$(YAY) $@ lazy$@
	sudo usermod -aG $@ ${USER}
	sudo systemctl --now enable docker

dunst:
	$(YAY) $@

dust:
	$(YAY) $@

exa:
	$(YAY) $@

fcitx5:
	$(YAY) $@-im
	echo -e 'ja_JP.UTF-8 UTF-8\nen_US.UTF-8 UTF-8' > /etc/locale.gen
	locale-gen
	echo 'LANG=ja_JP.UTF-8' > /etc/locale.conf

fd:
	$(YAY) $@

fzf:
	$(YAY) $@

git:
	$(YAY) $@ lazy$@

i3:
	# $(YAY) $@
	$(YAY) $@lock-color

jq:
	$(YAY) $@

lf:
	$(YAY) $@ ctpv-git vimv-git ffmpegthumbnailer

libreoffice:
	$(YAY) $@-still

maim:
	$(YAY) $@

mpv:
	$(YAY) $@ $@-mpris

nord-theme:
	$(YAY) nordic-darker-theme nordzy-cursors fcitx5-nord

nvim:
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

rclone:
	$(YAY) $@

redshift:
	$(YAY) $@

ripgrep:
	$(YAY) $@

rofi:
	$(YAY) $@

rofi-greenclip:
	$(YAY) $@

stow:
	$(YAY) $@

trash-cli:
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

yay:
	mkdir -p ~/src/
	cd ~/src/
	git clone https://aur.archlinux.org/yay.git
	cd yay/ && makepkg -si
	sudo sed -i 's/#Color/Color/' /etc/pacman.conf
	sudo sed -i 's/#ParallelDownloads/ParallelDownloads/' /etc/pacman.conf
	yay

zathura:
	$(YAY) $@

zk:
	$(YAY) $@

zoxide:
	$(YAY) $@

zsh:
	$(YAY) $@ $@-antidote
	chsh -s $(shell which zsh)

link: stow
	stow dotfiles

systemd: #config systemd
	sudo sed -i 's/#SystemMaxUse=/SystemMaxUse=50M' /etc/systemd/journald.conf
	sudo systemctl restart systemd-journald

docker_image: docker
	docker build -t dotfiles ${PWD}

test: docker_image ## test Makefile
	docker run -it --name maketest -d dotfiles:latest /bin/bash

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
