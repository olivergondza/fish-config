function pdiff --description "Visualize difference between 2 snippets"
  read --prompt "echo -e 'A:\n'" -l A
  read --prompt "echo -e 'B:\n'" -l B
  echo ""
  echo "===================="
  echo ""

  if [ (count $argv) -eq 0 ]
    set inv "sdiff -s"
  else
    set inv $argv
  end
  eval $inv (echo $A|psub) (echo $B|psub)
end
