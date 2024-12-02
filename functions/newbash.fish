function newbash --description "Create empty bash file and prepare for execution"
    curl -Ss --fail-with-body -o $argv[1] https://raw.githubusercontent.com/olivergondza/bash-strict-mode/refs/heads/master/strict-mode.sh
    chmod +x $argv[1]
    commandline -r 'bash '$argv[1]
end
