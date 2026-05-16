# Pick PID and port from lsof, use ps to print full process args
function ports --description "List open ports on localhost"
    # https://unix.stackexchange.com/a/27873/96990
    sudo lsof -iTCP -sTCP:LISTEN -P -n | awk '
          NR>1 {
            print $2"\t"$9
          }
      ' | xargs -n2 sh -c '
          printf "%20s  %7s  " "$2" "$1"
          ps -p "$1" -o args= 2>/dev/null
        ' sh
end
