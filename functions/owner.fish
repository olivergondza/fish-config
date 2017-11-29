function owner -d "find package that owns executable"
  set plainpath (which $argv[1])
  and set installpath (readlink -f $plainpath)
  and pacman -Qo $installpath
end
