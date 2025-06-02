function vpnoff
    kdestroy
    nmcli connection down "RH-BRQ"
end
