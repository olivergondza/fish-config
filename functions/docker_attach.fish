function docker_attach -a container_name -d "Run interactive shell inside a running container"
  set out "(docker ps -q)"
  if [ $status -ne 0 ]
      sudo systemctl start docker
  end

  if [ (count $argv) -eq 1 ]
      docker exec -it "$argv[1]" /bin/bash
  else
      docker ps
  end
end
