# Why
If you simply add a VPN using common instructions, it generally fails open. That means, if the VPN breaks down, because the connection is interrupted, traffic will be send without the VPN.

It's much safer when it fails closed, i.e. when the VPN connection breaks down, the whole internet connection must be down as long as the VPN connection isn't restored.

# What does it do

* Forbid outgoing traffic after the VPN software broke down for some reason.
* Tight firewall rules, using iptables policy drop.
* Only tested with OpenVPN. Should work with other VPN clients such as PPTP in theory, you should test if it does what it claims anyway.
* Only tested on Debian Wheezy and [Whonix-Workstation](https://github.com/adrelanos/Whonix). Should work on any other Linux distribution in theory, you should test if it does what it claims.
* Open Source / Free Software

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
* Prevent leaks caused by bugs in the VPN software.
* Be compatible with Whonix-Gateway. (VPN-Firewall is incompatible with Whonix-Gateway's firewall!)
* Run the VPN software as unprivileged user. For OpenVPN see
[OpenVPN wiki UnprivilegedUser](https://community.openvpn.net/openvpn/wiki/
UnprivilegedUser).
* Manage IPv6 traffic. IPv6 traffic is blocked.
* Install (Open)VPN.
* Configure (Open)VPN.
* Autostart (Open)VPN.
* Anything else not mentioned above in "What does it do".

# How to Use
1) First learn how to get your VPN software connected without using VPN-Firewall.

Use the IP to connect to your VPN server, not the hostname!

2) Remove old versions of VPN-Firewall.

    sudo update-rc.d vpnfirewall remove
    sudo rm /usr/local/bin/vpnfirewall
    sudo rm /usr/bin/vpnfirewall
    sudo rm /etc/init.d/vpnfirewall

3) Get the firewall script and install it.

    cd ~

    git clone https://github.com/adrelanos/VPN-Firewall.git

    cd VPN-Firewall

    sudo cp ./usr/bin/vpnfirewall /usr/bin/

4) Edit the /usr/bin/vpnfirewall settings with your favorite editor.

Note, that you must use the IP of your VPN server, not the hostname.

5) Load /usr/bin/vpnfirewall before the network and before OpenVPN goes up.

* If you are NOT permanently using (Open)VPN, i.e. if you only occasionally, manually connect to the VPN.

Just run the following command before starting OpenVPN.

    sudo /usr/bin/vpnfirewall

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

* One could play with the linux equivalent of the [route](http://cranthetrader.blogspot.se/2011/10/dont-allow-non-vpn-traffic.html) command.
* [Hardening your VPN Setup with iptables](http://www.inputoutput.io/hardening-your-vpn-setup-with-iptables/)
* [VPNCheck](http://www.guavi.com/vpncheck_free.html) - No source code. Nice looking user interface.
* [VPNetMon](http://vpnetmon.webs.com/) - No source code. Windows only. Checks every, let's say 500 ms, if the VPN IP is still valid, if not, kill a list of applications. This is not very secure, it's a game if that time period is sufficient to stop a leak and if killing the applications is fast enough. Nice looking user interface.
* [OPENVPN Watchdog](http://openvpnchecker.com/) - No source code. Windows only. Nice looking user interface.
* [VPN Lifeguard](https://sourceforge.net/projects/vpnlifeguard/) supports PPTP and IPSec, not OpenVPN. Windows only. Nice looking user interface.
* [ForceBindIP](http://www.r1ch.net/stuff/forcebindip/) - Bind any Windows application to a specific interface. No source code. Windows only.
* Some individual VPN services distribute closed source applications with vendor lock in. Nice looking user interfaces.
* One could tighten the firewall rules even more, by creating a dedicated user account for (Open)VPN, allow only the (Open)VPN process to connect to the VPN server. (VPN-Firewall lets all processes connect to the VPN IP, not only (Open)VPN. However, the setup would become more difficult, it may require modifying the OpenVPN init script.)
* Much safer would be, if one would build something similar to [Whonix](https://github.com/adrelanos/Whonix). Very briefly, while Whonix uses Tor and consists of a Gateway and a Workstation, since the Workstation doesn't know it's own external IP, the Workstation can never leak it and never connect in the clear. One could create similarly a VPNBOX.

# Forks, Patches, Testers, Comments, etc.

Welcome.

# Author

* Patrick Schleizer
* e-mail: adrelanos@riseup.net
* [gpg](https://www.whonix.org/wiki/Patrick_Schleizer): 916B8D99C38EAF5E8ADC7A2A8D66066A2EEACCDA
* twitter: https://twitter.com/Whonix
* [Donate](https://www.whonix.org/wiki/Donate)

# License

GPLv3+
