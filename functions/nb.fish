function nb --description "Create new bash file with safe mode"
  curl -SsL -o $argv[1] https://raw.githubusercontent.com/olivergondza/bash-strict-mode/master/strict-mode.sh
  chmod +x $argv[1]
end
