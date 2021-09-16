function history_delete_current_line --description "Delete current arg line from history"
  set line (commandline -b | string trim)
  if [ $line = "" ]
    return
  end
  echo ""

  set removed (history search --exact --case-sensitive $line | wc -l)
  history delete --exact --case-sensitive $line

  echo "Removed entries from Fish history: "$removed
  if [ $removed != 0 ]
    commandline -r ""
  end
  commandline -f repaint
end
