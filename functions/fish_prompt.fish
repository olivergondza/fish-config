function fish_prompt --description 'Write out the prompt'
    if nmcli connection show "Brno (BRQ)" | grep "GENERAL.STATE.*activated" > /dev/null
        set VPN "VPN "
    else
        set VPN ""
    end

    printf '%s> ' $VPN
end

function actual_fish_prompt --on-event fish_prompt --description 'Write out the prompt'
    #Save the return status of the previous command
    set stat $status

    # Notify if command took too long
    set last_command $history[1]
    if test $CMD_DURATION
        set secs (math "$CMD_DURATION / 1000")
        if test $secs -gt 60; and _is_background_completion
            if test $stat -eq 0
                set urg "normal"
                set ball "🟢 "
            else
                set urg "critical"
                set ball "🔴 "
            end
            notify-send --urgency=$urg "$ball $last_command" "Returned $stat, took $secs seconds"
            # It appears the prompt gets regenerated when urxvt windows resized
            # causing the notification to be resent repeatedly. Erase the CMD_DURATION
            # to avoid that
            set -e CMD_DURATION
        end
    end

    # Just calculate these once, to save a few cycles when displaying the prompt
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

    printf '%s%s %s%s' "$__fish_color_blue" $USER
    if [ $stat -ne 0 ]
        echo -n "$__fish_prompt_cwd_failed"(prompt_pwd)" $__fish_color_status$stat$__fish_prompt_normal"
    else
        echo -n "$__fish_prompt_cwd"(prompt_pwd)"$__fish_prompt_normal"
    end
    set -g __fish_git_prompt_show_informative_status true
    set -g __fish_git_prompt_char_stateseparator ' '
    echo (fish_git_prompt&&echo ' '||echo ' $ ')
end

function _is_background_completion --description "Determine whether a command is worth reporting its completion"
    set current_desktop_id (xprop -root -notype _NET_CURRENT_DESKTOP | awk '{ print $3 }')
    if [ $current_desktop_id -eq 0 ]
        return 1
    else
        return 0
    end
end
