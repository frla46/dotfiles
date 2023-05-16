.DEFAULT_GOAL = help
# .PHONY = setup pkgs link conf

YAY := yay -S --needed --noconfirm

help: ## show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
	| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

all: minimal cui gui conf ## init all
minimal: yay link git nvim zsh ## init minimal
cui: aria2 at atool bat bottom docker dust exa fcitx5 fd fzf jq lf procs protonvpn-cli rclone ripgrep trash-cli tree ufw zk zoxide ## init cui
gui: alacritty chromium discord dunst i3 libreoffice maim mpv nord-theme picom playerctl pqiv pulsemixer redshift rofi rofi-greenclip ttf-hackgen unclutter zathura ## init gui
conf: docker_conf locale_conf systemd_conf zsh_conf dns_conf ## config


link: stow ## symlink dotfiles
	stow -Rv -t ~ dotfiles

test: docker ## test Makefile
	docker build -t dotfiles ${PWD}
	docker run -it --name make_test -d dotfiles:latest /bin/bash

update: ## update packages
	yay

backup_home:
	time rclone sync ${HOME}/backup home:HOME

restore_home:
	time rclone sync home:home ${HOME/backup}

backup_res:
	time rclone sync ${HOME}/backup home:res

restore_res:
	time rclone sync home:res ${HOME/backup}

# packages
alacritty:
	$(YAY) $@

aria2:
	$(YAY) $@

at:
	$(YAY) $@

atool:
	$(YAY) $@
	$(YAY) zip unzip
	# $(YAY) bzip2 cpio gzip lha xz lzop p7zip tar unace unrar zip unzip

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
	sudo usermod -aG $@ $(shell whoami)

dunst:
	$(YAY) $@

dust:
	$(YAY) $@

exa:
	$(YAY) $@

fcitx5:
	$(YAY) $@ $@-gtk $@-qt $@-configtool $@-mozc

fd:
	$(YAY) $@

fzf:
	$(YAY) $@

git:
	$(YAY) $@ lazy$@

i3:
	$(YAY) $@-wm $@status $@lock-color

jq:
	$(YAY) $@

lf:
	$(YAY) $@ ctpv-git vimv-git ffmpegthumbnailer trash-cli

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

rofi-greenclip: rofi
	$(YAY) $@

stow:
	$(YAY) $@

tree:
	$(YAY) $@

ttf-hackgen:
	$(YAY) $@

ufw:
	$(YAY) $@

unclutter:
	$(YAY) $@

vivaldi:
	$(YAY) $@

yay: ## install yay
	mkdir -p ~/src/
	-cd ~/src/ && git clone https://aur.archlinux.org/yay.git && cd yay/ && makepkg -si
	$(YAY) yay reflector rsync
	sudo reflector -c jp -p https,rsync -l 5 --save /etc/pacman.d/mirrorlist
	sudo sed -i 's/#Color/Color/' /etc/pacman.conf
	sudo sed -i 's/#ParallelDownloads/ParallelDownloads/' /etc/pacman.conf

zathura:
	$(YAY) $@

zk:
	$(YAY) $@

zoxide: fzf
	$(YAY) $@

zsh: zoxide
	$(YAY) $@ $@-antidote


# config
dns_conf:
	$(YAY) dnsmasq
	sudo sed -i 's/dns=none/dns=dnsmasq/' /etc/NetworkManager/NetworkManager.conf
	sudo systemctl restart NetworkManager

docker_conf: docker
	sudo systemctl --now enable docker

locale_conf:
	echo -e 'ja_JP.UTF-8 UTF-8\nen_US.UTF-8 UTF-8' | sudo tee -a /etc/locale.gen
	locale-gen
	echo 'LANG=ja_JP.UTF-8' | sudo tee -a /etc/locale.conf

systemd_conf:
	sudo sed -i 's/#SystemMaxUse=/SystemMaxUse=50M/' /etc/systemd/journald.conf
	sudo systemctl restart systemd-journald

ufw_conf: ufw
	sudo ufw default deny
	sudo ufw enable

zsh_conf: zsh
	cat /etc/shells
	chsh


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
