function vpnoff
    kdestroy
    nmcli connection down "Brno (BRQ)"
end
