function icat --description "Show multiple images in console"
  for img in $argv;
    kitty +kitten icat --align=left $img
  end
end
