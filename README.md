# Evan's configs

### Set-up

Follow these steps:
1. install `vim` and `git`.
2. run
```shell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/evanq123/linux-setup/master/install.sh)"
source ~/.bash_profile
```

### Rasbian-stretch
1. after flashing rasbian stretch to sd card, navigate to volume/boot/ and do `touch ssh`
* optionally, `touch wpa_supplicant.conf` and set up network ESSID/PS:
```shell
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
network={
    ssid="YOUR_NETWORK_NAME"
    psk="YOUR_PASSWORD"
    key_mgmt=WPA-PSK
}
```
2. change raspbian default password from `raspberry` by entering `passwd`
3. install `sudo apt-get install screen` and do `screen -S install_setup` to create a new screen in case of disconnects.
2. `sudo raspi-config` to edit localisation and network options
2. configure wifi.
```shell
wpa_passphrase "testing" | sudo tee -a /etc/wpa_supplicant/wpa_supplicant.conf > /dev/null
```
3. configure static ip.
```shell
sudo vi /etc/dhcpcd.conf
```
...type in the following to `dhcpcd.conf` then `sudo reboot`
```shell
# Found by route -n
interface eth0
static ip_address=192.168.1.12

interface wlan0
static ip_address=192.168.1.13
static routers=192.168.1.1
# Found by cat /etc/resolv.conf
static domain_name_servers=202.62.64.3
8.8.8.8
```
3. install python3.
4. install java.


### Customize

You don't like the colors of your prompt? Open `~/.git-bash.sh` and mod it.

In addition, by simply exporting a couple of variables in `~/.git-bash.sh` you can make you prompt even more informative:
* if you set `export GIT_PS1_SHOWDIRTYSTATE=1`, unstaged (*) and staged (+) changes will be shown next to the branch name;
* if you set `export GIT_PS1_SHOWSTASHSTATE=1` and something is stashed then a '$' will be shown next to the branch name;
* if you set `export GIT_PS1_SHOWUNTRACKEDFILES=1` and there are untracked files then a '%' will be shown next to the branch name.

More info and options can be found [here](https://git-scm.com/book/en/v2/Appendix-A%3A-Git-in-Other-Environments-Git-in-Bash).
