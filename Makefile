.PHONY = setup pkgs link conf

current_dir := $(shell pwd)

packages := alacritty aria2 atool chromium clamav deja-dup discord dunst exa fcitx5-im fcitx5-nord fd fzf git i3 lazygit lf lxappearance maim man-pages-ja mpv neovim nordic-darker-theme noto-fonts-cjk picom protonvpn-cli pqiv redshift ripgrep rofi rofi-greenclip stow trash-cli ttf-hackgen ufw unclutter zathura zsh ctpv-git vimv zsh-antidote zoxide nordzy-cursors bottom i3lock-color playerctl mpv-mpris mpd

setup: yay pkg link conf

yay:
	git clone https://aur.archlinux.org/yay.git
	cd yay
	makepkg -si

pkg:
	yay
	yay --needed -S ${packages}

link:
	cd ${current_dir}
	stow -v dotfiles

conf:
	# shell
	chsh -s $(shell which zsh)
	# japanese
	echo -e 'ja_JP.UTF-8 UTF-8\nen_US.UTF-8 UTF-8' > /etc/locale.gen
	locale-gen
	echo 'LANG=ja_JP.UTF-8' > /etc/locale.conf
	# pacman
	sudo sed -i 's/#Color/Color/' /etc/pacman.conf
	sudo sed -i 's/#ParallelDownloads/ParallelDownloads/' /etc/pacman.conf
	# ufw
	sudo ufw default deny
	sudo ufw enable
	# systemd journal
	sudo sed -i 's/#SystemMaxUse=/SystemMaxUse=50M' /etc/systemd/journald.conf
	sudo systemctl restart systemd-journald

## todo
# clamav config
# lxappearance gtk-theme cursor-theme
# add cronrab deja-dup --backup
# browser config
#	- chromium or vivaldi
#	- chrome://flags/#enable-force-dark -> CIELAB based inversion
#	- extentions:
#		- bitwarden
#		- Blocktube
#		- BookmarkCleanUp
#		- copyAllURLs
#		- DuplicateTabCloser
#		- Feedbro
#		- Keepa
#		- LINE
#		- MALSync
#		- pdfViewerForVimiumC
#		- uAutoPagerize
#		- uBlacklist
#		- ubo
#		- videoDownloadHelper
#		- videoSpeedController
#		- vimiumC
