function vpnon
    set network "RH-BRQ"
    nmcli connection up $network --ask
    and pass show rh/identity.corp.redhat.com/ogondza | kinit
end
