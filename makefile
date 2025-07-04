.DEFAULT_GOAL = help

YAY := yay -S --needed --noconfirm

help: ## show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
	| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

link: ## set symlink dotfiles
	$(YAY) stow
	stow -Rv -t ~ dotfiles

yay: ## install yay
	mkdir -p ~/src/
	cd ~/src/ && git clone https://aur.archlinux.org/yay.git
	cd ~/src/yay/ && makepkg -si
	$(YAY) yay reflector
	sudo reflector -c jp -p https,http -l 5 --save /etc/pacman.d/mirrorlist
	sudo sed -i 's/#Color/Color/' /etc/pacman.conf
	sudo sed -i 's/#ParallelDownloads/ParallelDownloads/' /etc/pacman.conf

minimal: ## install minimal packages
	$(YAY) zsh wezterm neovim git sheldon starship

install: ## install packages from pkglist.bak
	$(YAY) - < ./pkglist.bak

at:
	$(YAY) $@
	sudo systemctl enable --now atd

cronie:
	$(YAY) $@
	sudo systemctl enable --now cronie

docker:
	$(YAY) $@
	sudo usermod -aG docker $(shell whoami)
	sudo systemctl --now enable docker

ufw:
	$(YAY) $@
	sudo ufw default deny
	sudo ufw enable
	sudo ufw status verbose
	sudo systemctl enable --now ufw

locale:
	echo -e 'ja_JP.UTF-8 UTF-8\nen_US.UTF-8 UTF-8' | sudo tee /etc/locale.gen
	sudo locale-gen
	echo 'LANG=ja_JP.UTF-8' | sudo tee -a /etc/locale.conf

systemd:
	sudo sed -i 's/#SystemMaxUse=/SystemMaxUse=50M/' /etc/systemd/journald.conf
	sudo systemctl restart systemd-journald

resolved:
	# sudo systemctl disable --now systemd-resolved
	echo 'nameserver 1.1.1.1' | sudo tee /etc/resolv.conf

zsh:
	$(YAY) zsh
	chsh -s $(shell which zsh)
