function docker_attach -a container_name -d "Run interactive shell inside a running container"
  set out "(docker ps -q)"
  if [ $status -ne 0 ]
      sudo systemctl start docker
  end

  if [ (count $argv) -eq 1 ]
      docker exec -it "$argv[1]" bash
  else if [ "1" = (docker ps -q | wc -l) ]
      set id (docker ps -q)
      echo >&2 "Attaching "$id
      docker exec -it $id bash
  else
      docker ps
  end
end
