#!/bin/bash

#Remove need to input passwords all the time
if [[ -z "$1" || $1 != -m && $1 != -a && $1 != -k ]]
then
	echo usage: sudo ./installs.sh OPTION [--no-pycharm]
	echo
	echo OPTION:
	echo -m : manually confirm each step
	echo -a : all at once
	echo -k : kubernetes etc included
	echo

	exit
fi

echo Are you logged in as sudo? y/n
read sudoer
if [ $sudoer != y ]
then 
	echo
	echo "##########################"
	echo Run this script as follows:
	echo $ chmod +x installs.sh
	echo $ sudo ./installs.sh \[OPTION\]
	echo "##########################"
	echo
	exit
fi
go=y
git_install=y
install_vim=y
install_zoom=y
install_chrome=y
install_slack=y
pycharm=y
docker=y
hello_docker=y
no_sudo=y
openvpn=y
teamviewer=y
kubectl=y
minikube=y
helm=y
pip=y
ansible=y
blueman=y
samba=y

# Update & Upgrade
sudo apt-get update
sudo apt-get upgrade

#Install a nice tool for tweaking your desktop
sudo add-apt-repository universe
sudo apt install gnome-tweak-tool

#Install a nice tree directory tool
sudo apt install tree

#Install Snap - a new package manager that Slack and PyCharm use to publish their software these days
echo Installing snapd

sudo snap install hello-world
hello-world

echo If the above line is not \"Hello World!\", please go to https://docs.snapcraft.io/installing-snap-on-ubuntu. Sorry about that...
echo please hit any key to continue, or Ctrl-C to exit
if [ $1 != -a ]
then
	read go
fi

# INSTALL GIT
echo Install Git?
if [ $1 != -a ]
then
	read git_install
fi
if [ $git_install != y ]
then
	echo not installing git
else
	 sudo apt-get install git
 fi

# INSTALL VIM
echo Install Vim? y/n
if [ $1 != -a ]
then
	read install_vim
fi
if [ $install_vim != y ]
then
	echo Not installing Vim
else
	sudo apt install vim
	echo If that didn\'t work, sorry...
fi

# INSTALL ZOOM
echo Install Zoom? y/n
if [ $1 != -a ]
then
	read install_zoom
fi
if [ $install_zoom != y ]
then
	echo Not installing Zoom
else
	wget https://zoom.us/client/latest/zoom_amd64.deb
	sudo dpkg -i zoom_amd64.deb
	sudo apt-get -f install
	echo If that didn\'t work, sorry...
fi

# INSTALL GOOGLE CHROME
echo Install Google Chrome?
if [ $1 != -a ]
then
	read install_chrome
fi
if [ $install_chrome != y ]
then
	echo Not installing Chrome
else
	# Google Chrome isn't in the repositories - however, Chromium is.
	# Google Chrome is only available for 64-bit Linux. I've included directions for 64 below.
	# To install Google Chrome, run the following:

	sudo apt-get install libxss1 libappindicator1 libindicator7
	wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
	sudo apt install ./google-chrome*.deb

	# If error messages pop up after running the command sudo apt install ./google-chrome*.deb then run the command
	# sudo apt-get install -f
	echo If that didn\'t work, sorry...
fi

# INSTALL SLACK
echo Install Slack?
if [ $1 != -a ]
then
	read install_slack
fi
if [ $install_slack != y ]
then
	echo not installing Slack.

else
	sudo snap install slack --classic
fi

# INSTALL PYCHARM
if [[ $2 == --no-pycharm ]]
then
	echo
	echo \##########################################
	echo Install PyCharm Professional \(p\), Community \(c\) or skip \(n\)?
	if [ $1 != -a ]
	then
		read pycharm
	fi
	if [ $pycharm == c ]
	then
		sudo snap install pycharm-community --classic
		echo hoping PyCharm is now installed?
	elif [ $pycharm == p ]
	then 
		sudo snap install pycharm-professional --classic
		echo hoping PyCharm is now installed?
	else
		echo not installing pycharm
	fi
else
	echo skipping pycharm
fi

# INSTALL DOCKER
echo Install Docker?
if [ $1 != -a ]
then
	read docker
fi
if [ $docker != y ]
then
	echo not installing docker now
else
	#Setting up Repo first
	sudo apt-get update
	sudo apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
	if ! [[ $(sudo apt-key fingerprint 0EBFCD88) ]]
	then
		echo There seems to be a problem with the fingerprint - go to https://docs.docker.com/install/linux/docker-ce/ubuntu/
	else
		sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

		echo Repository has been set up
		echo "#######################################"
		echo "#######################################"
		echo "#######################################"
		echo Installing Docker now

		#Install Docker
		sudo apt-get install docker-ce docker-ce-cli containerd.io
		echo Run Hello World container? y/n
		if [ $1 != -a ]
		then
			read hello_docker
		fi
		if [[ $hello_docker != y ]]
		then
			echo cool
		else
			sudo docker run hello-world
			echo Now go to https://docs.docker.com/install/linux/linux-postinstall/ for post-installation steps
		fi
		echo Or you could try to automate that too?
		if [ $1 != -a ]
		then
			read no_sudo
		fi
		if [[ $no_sudo != y ]]
		then
			echo OK
		else
			sudo groupadd docker
			sudo usermod -aG docker $USER
	fi
fi
fi

# INSTALL OPENVPN
echo Install OpenVPN? y/n
if [ $1 != -a ]
then
	read openvpn
fi
if [ $openvpn != y ]
then
	echo not installing openvpn
else
	sudo apt install openvpn
	echo Hoping the install worked!
fi

# INSTALL TEAMVIEWER
echo Install TeamViewer? y/n
if [ $1 != -a ]
then
	read teamviewer
fi
if [ $teamviewer != y ]
then
	echo not installing teamviewer
else
	wget https://download.teamviewer.com/download/linux/teamviewer_amd64.deb
	sudo apt install ./teamviewer_amd64.deb
fi

# INSTALL PIP
echo Install pip3?
if [ $1 != -a ]
then
	read pip
fi
if [ $pip != y ]
then
	echo not installing pip3
else
	sudo apt install python3-pip
	echo pip=\"pip3\" >> testfile #~/.bash_aliases
fi

# INSTALL ANSIBLE
echo Install ansible?
if [ $1 != -a ]
then
	read ansible
fi
if [ $ansible != y ]
then
	echo not installing ansible
else
	sudo apt-add-repository --yes --update ppa:ansible/ansible 
	sudo apt-get install ansible

	echo hopefully installed ansible
fi

# INSTALL BLUEMAN
echo Install Bluetooth Manager\)? y/n
if [ $1 != -a ]
then
	read blueman
fi
if [ $blueman != y ]
then
	echo not installing blueman
else
	sudo apt-get install blueman
fi

# INSTALL SAMBA CLIENT
echo Install Samba Client for accessing samba shared drive? y/n
if [ $1 != -a ]
then
	read samba
fi
if [ $samba != y ]
then
	echo not installing samba
else
	sudo apt install smbclient
fi

if [ $1 == -k ]
then
	# INSTALL KUBECTL
	echo Install Kubectl? y/n
	if [ $1 != -a ]
	then
		read kubectl
	fi
	if [ $kubectl != y ]
	then
		echo not installing kubectl
	else
		sudo snap install kubectl --classic
		echo hopefully succeeded installing kubectl. If not, sorry...
	fi

	# INSTALL MINIKUBE
	echo Install Minikube? y/n
	if [ $1 != -a ]
	then
		read minikube
	fi
	if [ $minikube != y ]
	then
		echo not installing minikube
	else
		curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
		chmod +x minikube
		sudo install minikube /usr/local/bin
	fi

	# INSTALL HELM
	echo Install Helm? y/n
	if [ $1 != -a ]
	then
		read helm
	fi
	if [ $helm != y ]
	then
		echo not installing helm
	else
		curl https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get | bash
	fi
fi
