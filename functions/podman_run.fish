function podman_run -a image_name -d "Run interactive shell inside a newly started container"
  podman run --interactive --rm --tty $argv /bin/bash
end
