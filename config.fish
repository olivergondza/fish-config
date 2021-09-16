source ~/.srch/completion/srch.fish
complete -c s -w srch
set -u SHELL fish
bind \cq history_delete_current_line

set PATH $PATH ~/code/jenkins/backend-commit-history-parser/bin ~/code/goreutils/bin
