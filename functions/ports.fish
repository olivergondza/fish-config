function ports --description "List open ports on localhost"
    # https://unix.stackexchange.com/a/27873/96990
    sudo lsof -iTCP -sTCP:LISTEN -P -n
end
