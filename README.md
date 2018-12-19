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

   interface wlan0
   static ip_address=192.168.1.13
   static routers=192.168.1.1
   # Found by cat /etc/resolv.conf
   static domain_name_servers=202.62.64.3
   8.8.8.8
   ```
7. Setup up `watchdog` to reboot pi when unresponsive.
   ```shell
   sudo apt-get install watchdog
   sudo echo bcm2708_wdog >> /etc/modules
   sudo cp /etc/watchdog.conf /etc/watchdog.conf.orig
   sudo sed -i 's/^#max-load/max-load/' /etc/watchdog.conf
   sudo reboot
   ```
   Test using `:(){ :|: & };:`
8. Install python3.
9. Install java.


### Customize

You don't like the colors of your prompt? Open `~/.git-bash.sh` and mod it.

In addition, by simply exporting a couple of variables in `~/.git-bash.sh` you can make you prompt even more informative:
* if you set `export GIT_PS1_SHOWDIRTYSTATE=1`, unstaged (*) and staged (+) changes will be shown next to the branch name;
* if you set `export GIT_PS1_SHOWSTASHSTATE=1` and something is stashed then a '$' will be shown next to the branch name;
* if you set `export GIT_PS1_SHOWUNTRACKEDFILES=1` and there are untracked files then a '%' will be shown next to the branch name.

More info and options can be found [here](https://git-scm.com/book/en/v2/Appendix-A%3A-Git-in-Other-Environments-Git-in-Bash).
