#!/bin/bash

#########################################################################################
# Run this command to get the script					  		#
# $curl https://raw.githubusercontent.com/mm4rk3t/tools/main/postsript.sh >> ps.sh	#
#  											#
# Edit the noroot variable and put YOUR username					#
# 											#
# Run the script									#
# $sudo chmod +x ps.sh && sudo ./ps.sh							#
#########################################################################################

# TO-DO
# [ ] Add more programs
# [ ] Add customization (select different de's)
# [ ] Configure dotfiles

# The user is also root if their UID is 0
if [ "$(whoami)" != root ]
then
	echo "Aborting. Must run as root."
	exit
fi

# Change this one
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

curl https://raw.githubusercontent.com/mm4rk3t/tools/main/packets.txt >> packages.txt
yay -S --needed - < packages.txt

if [ $(ls /usr/bin/gnome*-session | wc -l) -gt 0 ]
then
	echo "gnome is already installed"
else
	yay -S gnome gdm gnome-control-center
	systemctl start gdm.service
	systemctl enable gdm.service
fi

echo "Done!"
exit
