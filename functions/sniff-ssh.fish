function sniff-ssh
  set CLIENT_NET "192.168.1.0/24"
  set TABLE_ID 100
  set MARK 1


  sudo fish -c "
    echo \"$TABLE_ID     mitmproxy\" >> /etc/iproute2/rt_tables
    iptables -t mangle -A PREROUTING -d $CLIENT_NET -j MARK --set-mark $MARK
    iptables -t nat -A PREROUTING -p tcp -s $CLIENT_NET --match multiport --dports 1024:65535 -j REDIRECT --to-port 9090

    ip rule add fwmark $MARK lookup $TABLE_ID
    ip route add local $CLIENT_NET dev lo table $TABLE_ID
  "
end
