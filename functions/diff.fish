function diff
    if contains -- "-r" $argv; or contains -- "--recursive" $argv
        command diff --color=auto $argv
    else
        git diff --no-index $argv
    end
end
