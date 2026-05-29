# Put mise tools on path
mise activate fish | source

source ~/.srch/completion/srch.fish
complete -c s -w srch

# ctrl+q: Delete command from fish history
set -u SHELL fish
bind \cq history_delete_current_line

set PATH $PATH ~/code/goreutils/bin ~/.go/bin
set -x GOPATH /home/ogondza/.go

# Generate dynamic completions
oc completion fish > ~/.config/fish/completions/oc.fish
kubectl completion fish > ~/.config/fish/completions/kubectl.fish
tkn completion fish > ~/.config/fish/completions/tkn.fish

eval "$(ssh-agent -c)"
