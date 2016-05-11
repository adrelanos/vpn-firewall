# Why
If you simply add a VPN using common instructions, it generally fails open. That means, if the VPN breaks down, because the connection is interrupted, traffic will be send without the VPN.

It's much safer when it fails closed, i.e. when the VPN connection breaks down, the whole internet connection must be down as long as the VPN connection isn't restored.

# What does it do

* Forbid outgoing traffic after the VPN / tunnel software broke down for some reason.
* Tight firewall rules, using iptables policy drop.
* Defeat [shared VPN/Tor server leak bug](https://github.com/adrelanos/vpn-firewall/issues/12)
* Only tested with OpenVPN. Should work with other VPN and tunnel clients such as PPTP in theory, you should test if it does what it claims anyway.
* Only tested on Debian Jessie. Should work in many Linux distribution supporting netfilter-persistent in theory, you should test if it does what it claims.
* Open Source / Free Software

# What does it NOT do

* Care about DNS leaks. Consult your VPN software's/provider's documentation and
configure /etc/resolv.conf to use the DNS server of your VPN server.
* Block WebRTC leaks.
* Defend against
[IP leaks](https://blog.torproject.org/blog/bittorrent-over-tor-isnt-good-idea).
If a locally installed application uses trickery to obtain the the users real
IP and sends it somewhere though the VPN.
* Defend against adversaries, which are in position to run code locally, i.e.
manipulate the firewall rules.
* Prevent any other kind trickery to circumvent using the VPN.
* Prevent leaks caused by bugs in the VPN software.
* Be compatible with Whonix-Gateway/Workstation. (VPN-Firewall is incompatible with Whonix-Gateway/Workstation's firewall! Use Whonix documentation and use their built-in features.)
* Manage IPv6 traffic. IPv6 traffic is blocked.
* Install (Open)VPN.
* Configure (Open)VPN.
* Autostart (Open)VPN.
* Anything else not mentioned above in "What does it do".
* Untested to work in Qubes ProxyVMs. (They have a different way to up networking and firewall.)

# How to Use

See:

https://www.whonix.org/wiki/VPN-Firewall#How_to_use_VPN-Firewall

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
