function fish_prompt --description 'Write out the prompt'
    #Save the return status of the previous command
    set stat $status

    # Just calculate these once, to save a few cycles when displaying the prompt
    if not set -q __fish_prompt_hostname
        set -g __fish_prompt_hostname (hostname|cut -d . -f 1)
    end

    if not set -q __fish_prompt_normal
        set -g __fish_prompt_normal (set_color normal)
    end

    if not set -q __fish_color_blue
        set -g __fish_color_blue (set_color brblue)
    end

    if not set -q __fish_prompt_cwd
        set -g __fish_prompt_cwd (set_color $fish_color_cwd)
    end

    if not set -q __fish_prompt_cwd_failed
        set -g __fish_prompt_cwd_failed (set_color red)
    end

    if not set -q __fish_color_status
        set -g __fish_color_status (set_color -o red)
    end

    printf '%s%s@%s %s%s' "$__fish_color_blue" $USER "$__fish_prompt_hostname"
    if [ $stat -ne 0 ]
        echo -n "$__fish_prompt_cwd_failed"(prompt_pwd)" $__fish_color_status$stat "
    else
        echo -n "$__fish_prompt_cwd"(prompt_pwd)' '
    end
    echo -n "$__fish_prompt_normal"'$ '
end
