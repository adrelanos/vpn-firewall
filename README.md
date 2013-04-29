# Why
If you simply add a VPN using common instructions, it generally fails open. That means, if the VPN breaks down, because the connection is interrupted, traffic will be send without the VPN.

It's much safer when it fails closed, i.e. when the VPN connection breaks down, the whole internet connection must be down as long as the VPN connection isn't restored.

# What does it do

* Forbid outgoing traffic after the VPN software broke down for some reason.
* Only tested with OpenVPN. Should work with other VPN clients such as PPTP in theory, you should test if it does what it claims anyway.
* Only tested on Debian Wheezy and [Whonix](https://github.com/adrelanos/Whonix). Should work on any other Linux distribution in theory, you should test if it does what it claims.

# What does it NOT do

* Care about DNS leaks. Consult your VPN software's/provider's documentation and
configure /etc/resolv.conf to use the DNS server of your VPN server.
* Defend against
[IP leaks](https://blog.torproject.org/blog/bittorrent-over-tor-isnt-good-idea).
If a locally installed application uses trickery to obtain the the users real
IP and sends it somewhere though the VPN.
* Defend against adversaries, which are in position to run code locally, i.e.
manipulate the firewall rules.
* Prevent any other kind trickery to circumvent using the VPN.
* Run the VPN software as unprivileged user. For OpenVPN see
[OpenVPN wiki UnprivilegedUser](https://community.openvpn.net/openvpn/wiki/
UnprivilegedUser).
* Configure (Open)VPN.
* Autostart (Open)VPN.

# How to Use
1) Get the firewall script and install it.

    cd ~

    git clone https://github.com/adrelanos/VPN-Firewall.git
    
    cd VPN-Firewall
    
    sudo cp ./usr/local/bin/vpnfirewall /usr/local/bin/
    
2) Edit the /usr/local/bin/vpnfirewall settings with your favorite editor. 

3) Load /usr/local/bin/vpnfirewall before the network and before OpenVPN goes up.

* If you are NOT permanently using (Open)VPN, i.e. if you only occasionally, manually connect to the VPN.

Just run the following command before starting OpenVPN.

    sudo /usr/local/bin/vpnfirewall

Should reply:

    OK: Loading VPN firewall...
    OK: The firewall should not show any messages,
    OK: besides output beginning with prefix OK:...
    OK: VPN firewall loaded.

* If you are permanently using (Open)VPN, i.e. always want to use the VPN.

Install the init script.

    sudo cp ./etc/init.d/vpnfirewall /etc/init.d/

    sudo update-rc.d vpnfirewall defaults
    
Test the init script.    
    
    sudo service vpnfirewall restart
    
    sudo service vpnfirewall status

    echo $?

Should reply:

    0

Reboot.

Check VPN Firewall status again.

    sudo service vpnfirewall status
    
Should reply:

    0

# How to Test

1) Install.

2) Test if it works. Check whatismyipaddress.com if you your external IP is from the VPN.

3) Kill the VPN client.

Example OpenVPN:

    sudo killall openvpn
    
4) Check if you can still connect to whatismyipaddress.com.

If yes, bad, something is wrong.

If no, good, you won't connect to any remote servers besides the VPN IP once the VPN client broke down.

# How to Debug

Developers only.

Enable debugging. Uncomment "set -x" in all scripts.

Check iptables logs.

    tail -f /var/log/syslog

# Alternatives

* There are some weak alternative ways to do this. Some "VPN-Monitor" check every, let's say 500 ms, if the VPN IP is still valid, if not, kill a list of applications. This is not very secure, it's a game if that time period is sufficient to stop a leak and if killing the applications is fast enough.
* One could play with the route command.
* Much safer would be, if one would build something similar to [Whonix](https://github.com/adrelanos/Whonix). Very briefly, while Whonix uses Tor and consists of a Gateway and a Workstation, since the Workstation doesn't know it's own external IP, the Workstation can never leak it and never connect in the clear. One could create similarly a VPNBOX.

# Forks, Patches, Testers, Comments, etc.

Welcome.

# Author

* e-mail: adrelanos at riseup dot net
* twitter: https://twitter.com/Whonix
* BTC / donate:

    1JgzCCSox56Sh4NnQJqRiwoxKi8oVSZBEd

# License

GPLv3+
