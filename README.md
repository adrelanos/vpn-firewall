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

# How to Use

TODO

# How to Test

1) Install.

2) Test if it works. Check whatismyipaddress.com if you your external IP is from the VPN.

3) Kill the VPN client.

Example OpenVPN:

  sudo killall openvpn
    
4) Check if you can still connect to whatismyipaddress.com.

If yes, bad, something is wrong.

If no, good, you won't connect to any remote servers besides the VPN IP once the VPN client broke down.

# Alternatives

* One could play with the route command.
* Much safer would be, if one would build something similar to [Whonix](https://github.com/adrelanos/Whonix). Very briefly, while Whonix uses Tor and consists of a Gateway and a Workstation, since the Workstation doesn't know it's own external IP, the Workstation can never leak it and never connect in the clear. One could create similary a VPNBOX.

# Author

* e-mail: adrelanos at riseup dot net
* twitter: https://twitter.com/Whonix

# License

GPLv3+
