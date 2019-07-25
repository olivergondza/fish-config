function issh --description "Make SSH connection to temorary server without worrying about the fingerprints"
  ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -o Loglevel=error $argv
end
complete -c issh -w ssh
