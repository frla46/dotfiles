.PHONY = setup

current_dir := $(shell pwd)
pacman := sudo pacman --needed  -S
yay := yay --needed  -S

packages := alacritty aria2 atool capitaine-cursors chromium clamav clamtk clipnotify deja-dup discord dunst exa fcitx5-im fcitx5-nord fd fzf git gotop lazygit lxappearance maim man-pages-ja neovim nordic-darker-theme noto-fonts-cjk picom protonvpn-cli qimgv ranger redshift ripgrep rofi stow trash-cli ttf-hackgen ufw unclutter zathura zsh mpv

setup: yay pkgs link conf

yay:
	git clone https://aur.archlinux.org/yay.git
	cd yay
	makepkg -si

pkgs:
	${yay} ${packages}

link:
	cd ${current_dir}
	stow -v dotfiles

conf:
	chsh -s $(which zsh)
	echo 'LANG=ja_JP.UTF-8' > /etc/locale.conf
	sudo sed -i 's/#Color/Color/' /etc/pacman.conf
