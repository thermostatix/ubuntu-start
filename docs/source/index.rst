
Ubuntu Provisioner
==================


Update
------
.. code-block:: bash

    sudo apt-get update
    sudo apt-get upgrade

Gnome Tweaks and Tools
----------------------
.. code-block:: bash

    sudo apt install tree

Git & Vim
---------
.. code-block:: bash

    sudo apt-get install git
    sudo apt install vim

Zoom
----
.. code-block:: bash

    wget https://zoom.us/client/latest/zoom_amd64.deb
    sudo dpkg -i zoom_amd64.deb
    sudo apt-get -f install

Bluetooth Manager
-----------------
.. code-block:: bash

    sudo apt-get install blueman

Chrome
------
.. code-block:: bash

    sudo apt-get install libxss1 libappindicator1 libindicator7
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo apt install ./google-chrome*.deb

Slack
-----
.. code-block:: bash

    sudo snap install slack --classic

Docker
------
.. code-block:: bash

    sudo apt-get update
    sudo apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    if ! [[ $(sudo apt-key fingerprint 0EBFCD88) ]]
    then
            echo There seems to be a problem with the fingerprint - go to https://docs.docker.com/install/linux/docker-ce/ubuntu/
    else
            sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    fi

    sudo apt-get install docker-ce docker-ce-cli containerd.io
    sudo groupadd docker
    sudo usermod -aG docker $USER

    # Run test
    docker run hello-world

OpenVPN
-------
.. code-block:: bash

    sudo apt install openvpn

TeamViewer
----------
.. code-block:: bash

    wget https://download.teamviewer.com/download/linux/teamviewer_amd64.deb
    sudo apt install ./teamviewer_amd64.deb

Pip
---
.. code-block:: bash

    sudo apt install python3-pip
    echo alias pip=\"pip3\" >> ~/.bash_aliases

Ansible
-------
.. code-block:: bash

    sudo apt-add-repository --yes --update ppa:ansible/ansible
    sudo apt-get install ansible

Samba Client
------------
.. code-block:: bash

    sudo apt install smbclient

Helm
----
.. code-block:: bash

    curl https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get | bash

