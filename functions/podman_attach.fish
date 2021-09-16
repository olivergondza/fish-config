function podman_attach -a container_name -d "Run interactive shell inside a running container"
  if [ (count $argv) -eq 1 ]
      podman exec -it "$argv[1]" bash
  else if [ "1" = (podman ps -q | wc -l) ]
      set id (podman ps -q)
      echo >&2 "Attaching "$id
      podman exec -it $id bash
  else
      podman ps
  end
end
