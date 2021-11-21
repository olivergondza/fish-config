source ~/.srch/completion/srch.fish
complete -c s -w srch
set -u SHELL fish
bind \cq history_delete_current_line

set PATH $PATH ~/code/goreutils/bin /home/ogondza/.go/bin
set -x GOPATH /home/ogondza/.go
