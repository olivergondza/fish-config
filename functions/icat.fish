function icat --description "Show multiple images in console"
  for img in $argv;
    echo $img
    kitty +kitten icat --align=left $img
  end
end
