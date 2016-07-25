function docker_run
  docker ps > /dev/null 2>&1 or sudo systemctl start docker
  docker run --interactive --rm --tty "$argv[1]" /bin/bash
end
