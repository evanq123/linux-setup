# dotfiles configurations and installation guides

### dotfiles/vim

Follow these steps:
1. Install `vim` and `git`.
2. Install `dotfiles` and `vim` packages by:
   ```shell
   # untested on macos
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/evanq123/linux-setup/master/install.sh)"
   source ~/.bash_profile
   ```

### Rasbian-stretch Installation
1. After flashing rasbian-stretch a sd card, `cd volume/boot/` and `touch ssh`.
   Optionally, `touch wpa_supplicant.conf` and set up network ESSID/PS:
   ```
   ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
   network={
       ssid="YOUR_NETWORK_NAME"
       psk="YOUR_PASSWORD"
       key_mgmt=WPA-PSK
   }
   ```
2. Change raspbian default password from `raspberry` by `passwd`.
3. `sudo apt-get install screen` and `screen -S install_setup` to create a new screen in case of disconnects.
4. `sudo raspi-config` to edit localization and network options
5. Configure wifi.
   ```shell
   wpa_passphrase "testing" | sudo tee -a /etc/wpa_supplicant/wpa_supplicant.conf > /dev/null
   ```
6. Configure static ip. Type in the following to `sudo vi /etc/dhcpcd.conf` then `sudo reboot`
   ```shell
   # Found by route -n
   interface eth0
   static ip_address=192.168.1.12
   static routers=192.168.1.1
   # Found by cat /etc/resolv.conf
   static domain_name_servers=8.8.8.8
   ```
7. Setup up `watchdog` to reboot pi when unresponsive.
   ```shell
   sudo apt-get install watchdog
   sudo echo bcm2708_wdog >> /etc/modules # Note, might need to do sudo -i
   sudo cp /etc/watchdog.conf /etc/watchdog.conf.orig
   sudo sed -i 's/^#max-load/max-load/' /etc/watchdog.conf
   sudo reboot
   ```
   Test using fork bomb: `:(){ :|: & };:` **Warning** will need to manually power-cycle if watchdog wasn't set up correctly.
8. Install `python3`.
   ```shell
   # Install dependencies
   sudo apt-get update
   sudo apt-get install -y build-essential tk-dev libncurses5-dev libncursesw5-dev libreadline6-dev libdb5.3-dev libgdbm-dev libsqlite3-dev libssl-dev libbz2-dev libexpat1-dev liblzma-dev zlib1g-dev libffi-dev
   curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
   # Add pyenv to load path as prompted by the warning.
   ```
   ```shell
   # Compiling/ Install
   CONFIGURE_OPTS=--enable-optimizations pyenv install 3.7.0 -v
   ```
   ```shell
   # Make Python 3.7 the default version, make aliases
   sudo ln -s /usr/local/opt/python-3.7.0/bin/pydoc3.7 /usr/bin/pydoc3.7
   sudo ln -s /usr/local/opt/python-3.7.0/bin/python3.7 /usr/bin/python3.7
   sudo ln -s /usr/local/opt/python-3.7.0/bin/python3.7m /usr/bin/python3.7m
   sudo ln -s /usr/local/opt/python-3.7.0/bin/pyvenv-3.7 /usr/bin/pyvenv-3.7
   sudo ln -s /usr/local/opt/python-3.7.0/bin/pip3.7 /usr/bin/pip3.7
   alias python3='/usr/bin/python3.7'
   pyenv global 3.7.0
   ls /usr/bin/python*
   cd ..
   sudo rm -r Python-3.7.0
   rm Python-3.7.0.tar.xz
   . ~/.bashrc
   ```
   ```shell
   # Verify
   python3 -V
   ```
9. Install java8.
   `vi key.txt` and copy the following into it:
   ```
   -----BEGIN PGP PUBLIC KEY BLOCK-----
Version: SKS 1.1.5
Comment: Hostname: keyserver.ubuntu.com

mI0ES9/P3AEEAPbI+9BwCbJucuC78iUeOPKl/HjAXGV49FGat0PcwfDd69MVp6zUtIMbLgkU
OxIlhiEkDmlYkwWVS8qy276hNg9YKZP37ut5+GPObuS6ZWLpwwNus5PhLvqeGawVJ/obu7d7
gM8mBWTgvk0ErnZDaqaU2OZtHataxbdeW8qH/9FJABEBAAG0DUxhdW5jaHBhZCBWTEOImwQQ
AQIABgUCVsN4HQAKCRAEC6TrO3+B2tJkA/jM3b7OysTwptY7P75sOnIu+nXLPlzvja7qH7Wn
A23itdSker6JmyJrlQeQZu7b9x2nFeskNYlnhCp9mUGu/kbAKOx246pBtlaipkZdGmL4qXBi
+bi6+5Rw2AGgKndhXdEjMxx6aDPq3dftFXS68HyBM3HFSJlf7SmMeJCkhNRwiLYEEwECACAF
Akvfz9wCGwMGCwkIBwMCBBUCCAMEFgIDAQIeAQIXgAAKCRDCUYJI7qFIhucGBADQnY4V1xKT
1Gz+3ERly+nBb61BSqRx6KUgvTSEPasSVZVCtjY5MwghYU8T0h1PCx2qSir4nt3vpZL1luW2
xTdyLkFCrbbIAZEHtmjXRgQu3VUcSkgHMdn46j/7N9qtZUcXQ0TOsZUJRANY/eHsBvUg1cBm
3RnCeN4C8QZrir1CeA==
=CziK
-----END PGP PUBLIC KEY BLOCK-----
```
``` shell
sudo apt-key add key.txt
echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" | sudo tee /etc/apt/sources.list.d/webupd8team-java.list
echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" | sudo tee -a /etc/apt/sources.list.d/webupd8team-java.list
sudo apt-get update
sudo apt-get install oracle-java8-installer

# Verify
java -version

# Switching between versions
update-java-alternatives -l
# Copy key from first column to command i.e.,
update-java-alternatives -s java-8-oracle
```

### Customize

You don't like the colors of your prompt? Open `~/.git-bash.sh` and mod it.

In addition, by simply exporting a couple of variables in `~/.git-bash.sh` you can make you prompt even more informative:
* if you set `export GIT_PS1_SHOWDIRTYSTATE=1`, unstaged (*) and staged (+) changes will be shown next to the branch name;
* if you set `export GIT_PS1_SHOWSTASHSTATE=1` and something is stashed then a '$' will be shown next to the branch name;
* if you set `export GIT_PS1_SHOWUNTRACKEDFILES=1` and there are untracked files then a '%' will be shown next to the branch name.

More info and options can be found [here](https://git-scm.com/book/en/v2/Appendix-A%3A-Git-in-Other-Environments-Git-in-Bash).
