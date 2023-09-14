.DEFAULT_GOAL = help

YAY := yay -S --needed --noconfirm

help: ## show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
	| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

all: minimal cui gui conf ## deploy all
minimal: yay link git nvim zsh lf fd rg procs eza bat  ## deploy minimal
cui: at atool bottom docker dust fcitx5 ttf-hackgen jq protonvpn-cli restic tree ufw zk cronie ## deploy cui
gui: alacritty chromium discord dunst i3 libreoffice maim megacmd mpv gtk-theme picom playerctl pqiv pulsemixer redshift rofi rofi-greenclip unclutter zathura binggpt-desktop-bin  ## deploy gui
conf: locale_conf systemd_conf zsh_conf nm_conf ## configure all

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


# packages
alacritty:
	$(YAY) $@

at:
	$(YAY) $@

atool:
	$(YAY) $@
	$(YAY) zip unzip tar
	# $(YAY) bzip2 cpio gzip lha xz lzop p7zip tar unace unrar zip unzip

bat:
	$(YAY) $@

bottom:
	$(YAY) $@

chromium:
	$(YAY) $@

cronie:
	$(YAY) $@

discord:
	$(YAY) $@ betterdiscordctl
	betterdiscordctl install

docker:
	$(YAY) $@ lazy$@
	sudo usermod -aG $@ $(shell whoami)
	sudo systemctl --now enable docker


dunst:
	$(YAY) $@

dust:
	$(YAY) $@

eza:
	$(YAY) $@

fcitx5:
	$(YAY) $@ $@-gtk $@-qt $@-configtool $@-mozc

fd:
	$(YAY) $@

git:
	$(YAY) $@ lazy$@

i3:
	$(YAY) $@-wm $@status $@lock-color

jq:
	$(YAY) $@

lf:
	$(YAY) $@ ctpv-git vimv-git ffmpegthumbnailer trash-cli xsel

libreoffice:
	$(YAY) $@-still

maim:
	$(YAY) $@

megacmd:
	$(YAY) $@

mpv:
	$(YAY) $@ $@-mpris

gtk-theme:
	$(YAY) nordic-darker-theme capitaine-cursors fcitx5-nord

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

redshift:
	$(YAY) $@

restic:
	$(YAY) $@

rg:
	$(YAY) ripgrep

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
	-cd ~/src/ && git clone https://aur.archlinux.org/yay.git && cd yay/ && makepkg -si
	$(YAY) yay reflector
	sudo reflector -c jp -p https,http -l 5 --save /etc/pacman.d/mirrorlist
	sudo sed -i 's/#Color/Color/' /etc/pacman.conf
	sudo sed -i 's/#ParallelDownloads/ParallelDownloads/' /etc/pacman.conf

zathura:
	$(YAY) $@ $@-pdf-poppler

zk:
	$(YAY) $@

zsh:
	$(YAY) $@ $@-antidote zoxide fzf

binggpt-desktop-bin:
	$(YAY) $@


# config
nm_conf:
	echo '[main]\ndns=none' | sudo tee /etc/NetworkManager/NetworkManager.conf
	sudo systemctl restart NetworkManager

locale_conf:
	echo -e 'ja_JP.UTF-8 UTF-8\nen_US.UTF-8 UTF-8' | sudo tee /etc/locale.gen
	locale-gen
	echo 'LANG=ja_JP.UTF-8' | sudo tee -a /etc/locale.conf

systemd_conf:
	sudo sed -i 's/#SystemMaxUse=/SystemMaxUse=50M/' /etc/systemd/journald.conf
	sudo systemctl restart systemd-journald

zsh_conf: zsh
	chsh -s $(shell which zsh)

# # todo
# set gtk-theme cursor-theme
# browser config
# - chrome://flags/#enable-force-dark -> CIELAB based inversion
# mega
# 	mega-login 'USERID' 'PASSWORD'
# 	mega-sync ~/backup/ /
