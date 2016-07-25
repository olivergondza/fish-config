function xfreerdp
  if [ (count $argv) -eq 2 ]
      command xfreerdp -g:1440x900 +clipboard /u:$argv[1] /v:$argv[2]
  else
      command xfreerdp "$args"
  end
end
