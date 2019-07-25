function nd --description "Create and enter a directory"
  mkdir -p $argv[1]; and cd $argv[1]
end
