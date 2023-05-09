function watch --description "Better watch"
  set last_out ""
  set last_status ""
  while :;
    set cmd_out (eval $argv 2>&1 | string collect)
    set cmd_status $pipestatus[1]
    if [ "$cmd_out" != "$last_out" ]; or [ "$last_status" != "$cmd_status" ]
      set color red
      if [ "$cmd_status" -eq 0 ];
        set color green
      end
      echo -n (set_color $color)
      command date +':: %Y-%m-%d %H:%M:%S (exit '$cmd_status')'
      echo -n (set_color normal)
      echo -e "$cmd_out"

      set last_out $cmd_out
      set last_status $cmd_status
    end
    sleep 1
  end
end
