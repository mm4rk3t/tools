#!/bin/bash

# sudo sh -c "$(curl https://raw.githubusercontent.com/mm4rk3t/tools/main/postsript.sh)"

# The user is also root if their UID is 0
if [ "$(whoami)" != root ]
then
	echo "Aborting. Must run as root."
	exit
fi

noroot="mm4rk3t"

echo "
██████   ██████  ███████ ████████ ███████  ██████ ██████  ██ ██████  ████████ 
██   ██ ██    ██ ██         ██    ██      ██      ██   ██ ██ ██   ██    ██    
██████  ██    ██ ███████    ██    ███████ ██      ██████  ██ ██████     ██    
██      ██    ██      ██    ██         ██ ██      ██   ██ ██ ██         ██    
██       ██████  ███████    ██    ███████  ██████ ██   ██ ██ ██         ██    
"

if [ $(command -v yay) ]
then
	echo "yay is already installed"
else
	sudo pacman -S base-devel git curl wget 
	git clone https://aur.archlinux.org/yay.git /tmp/yay
	sudo chown -R $noroot:users /tmp/yay
	(cd /tmp/yay && sudo -u $noroot makepkg -si)
fi

if [ $(ls /usr/bin/gnome*-session | wc -l) -gt 0 ]
then
	echo "gnome is already installed"
else
	yay -S gnome gdm gnome-control-center
	systemctl start gdm.service
	systemctl enable gdm.service
fi

if [ $(command -v zsh) ]
then
	echo "zsh already installed"
else
	yay -S zsh
	sudo -u $noroot sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

declare -a programs=(
"neovim"
"mpv" 
"firefox" 
"alacritty" 
"discord" 
"mousepad"
)

for p in ${programs[@]}
do
	if [ $(command -v $p) ]
	then
        	echo "$p already installed"
	else
        	yay -S $p
	fi
done

echo "Done!"
exit
