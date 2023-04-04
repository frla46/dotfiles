.PHONY = setup pkgs link conf

current_dir := $(shell pwd)

packages := alacritty aria2 atool capitaine-cursors chromium clamav deja-dup discord dunst exa fcitx5-im fcitx5-nord fd fzf git i3 lazygit lf lxappearance maim man-pages-ja mpv neovim nordic-darker-theme noto-fonts-cjk picom protonvpn-cli pqiv redshift ripgrep rofi rofi-greenclip stow trash-cli ttf-hackgen ufw unclutter zathura zsh ctpv-git vimv

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
	# todo: clamav
	# todo: lxappearance gtk-theme cursor-theme
	# todo: add cronrab deja-dup --backup
