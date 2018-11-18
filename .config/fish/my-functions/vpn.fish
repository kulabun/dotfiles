#!/usr/bin/env fish

function vpn
    set -l vpn_config "/etc/openvpn/ovpn_tcp/"(ls /etc/openvpn/ovpn_tcp/ | egrep "*.ovpn" | shuf | tail -1)
    cat $vpn_config | sed "s/auth-user-pass.*/auth-user-pass \/etc\/openvpn\/client\/.secret/" > /tmp/nordvpn.conf
    sudo mv /tmp/nordvpn.conf /etc/openvpn/client/nordvpn.conf
    sudo /usr/bin/openvpn --suppress-timestamps --nobind --config /etc/openvpn/client/nordvpn.conf | sudo tee /var/log/openvpn.log > /dev/null & disown
end
