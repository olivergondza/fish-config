function docker_run -a image_name -d "Run interactive shell inside a newly started container"
  docker ps > /dev/null 2>&1; or sudo systemctl start docker
  docker run --interactive --rm --tty $argv /bin/bash
end
