function vpnon
    set network "RH-BRQ2"
    nmcli connection up $network --ask
    if [ $status -eq 0 -o $status -eq 4 ] # 4 for already UP
        return $status
    end
    pass show rh/identity.corp.redhat.com/ogondza | kinit
end
