function watch --description "Better watch"
  set last ""
  while :;
    #set current "$(eval $argv)" https://github.com/fish-shell/fish-shell/commit/5999d660c00546dea9b00b97722eb11ad9bb4ff7
    set current (eval $argv)
    if [ "$current" != "$last" ]
      date
      echo -e "$current"
      set last $current
    end
    sleep 1
  end
end
