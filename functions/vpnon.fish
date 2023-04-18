function vpnon
    nmcli connection up "Brno (BRQ)" --ask
    and pass show rh/identity.corp.redhat.com/ogondza | kinit
end
