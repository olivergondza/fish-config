source ~/.srch/completion/srch.fish
complete -c s -w srch
set -u SHELL fish
bind \cq history_delete_current_line

set PATH $PATH ~/code/goreutils/bin ~/.go/bin
set -x GOPATH /home/ogondza/.go

# Force newer than whichever is default ATM
set -x IDEA_JDK /usr/lib/jvm/java-17-openjdk/

# Generate latest origin-client completions
oc completion fish > ~/.config/fish/completions/oc.fish
