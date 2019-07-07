#Remove need to input passwords all the time
echo Are you logged in as sudo? y/n
read sudoer
if [ $sudoer != y ]
then 
	echo
	echo "##########################"
	echo Run this script as follows:
	echo $ sudo chmod +x installs.sh
	echo $ sudo ./installs.sh
	echo "##########################"
	echo
	sudo chmod +x installs.sh
	sudo ./installs.sh
	return
fi

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
read go

echo Install Git?
read git_install

if [ $git_install != y ]
then
	echo not installing git
else
	 sudo apt-get install git
 fi

# Install Vim
echo Install Vim? y/n
read install_vim

if [ $install_vim != y ]
then
	echo Not installing Vim
else
	sudo apt install vim
	echo If that didn\'t work, sorry...
fi

# Install Zoom
echo Install Zoom? y/n
read install_zoom

if [ $install_zoom != y ]
then
	echo Not installing Zoom
else
	wget https://zoom.us/client/latest/zoom_amd64.deb
	sudo dpkg -i zoom_amd64.deb
	sudo apt-get -f install
	echo If that didn\'t work, sorry...
fi

echo Install Google Chrome?
read install_chrome

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

echo Install Slack?
read install_slack

if [ $install_slack != y ]
then
	echo not installing Slack.

else
	sudo snap install slack --classic
fi

# Install PyCharm
echo Install PyCharm Professional or Community?
echo Choose P or C \(Capital Letters!\), or hit any other key to skip Pycharm installation
read install_pycharm

if [ $install_pycharm != P ]
then
	if [ $install_pycharm != C ]
	then
		echo not installing Pycharm.
	else
		sudo snap install pycharm-community --classic
	fi
else
	sudo snap install pycharm-professional --classic
	echo hoping PyCharm is now installed?
fi

#Install Docker
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
		read hello_docker
		if [[ $hello_docker != y ]]
		then
			echo cool
		else
			sudo docker run hello-world
			echo Now go to https://docs.docker.com/install/linux/linux-postinstall/ for post-installation steps
		fi
		echo Or you could try to automate that too?
		read no_sudo
		if [[ $no_sudo != y ]]
		then
			echo OK
		else
			sudo groupadd docker
			sudo usermod -aG docker $USER
	fi
fi



echo Install OpenVPN? y/n
read openvpn

if [ $openvpn != y ]
then
	echo not installing openvpn
else
	sudo apt install openvpn
	echo Hoping the install worked!
fi

echo Install TeamViewer? y/n
read teamviewer

if [ $teamviewer != y ]
then
	echo not installing teamviewer
else
	wget https://download.teamviewer.com/download/linux/teamviewer_amd64.deb
	sudo apt install ./teamviewer_amd64.deb
fi

echo Install Kubectl? y/n
read kubectl

if [ $kubectl != y ]
then
	echo not installing kubectl
else
	sudo snap install kubectl --classic
	echo hopefully succeeded installing kubectl. If not, sorry...
fi
