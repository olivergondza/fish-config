function assh --description "Make SSH connection to temporary server without worrying about the fingerprints"
  kitty +kitten ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -o Loglevel=error $argv
end
complete -c assh -w ssh
