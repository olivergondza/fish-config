function jenkins-groovy
  # set oldIFS "$IFS"
  # set ISF ""
  # set script (cat $argv[2])
  # set IFS "$oldIFS"
  # and echo "$script"
  # curl --negotiate -u : --data-urlencode script=$script $argv[1]/scriptText
  bash -o pipefail -c "curl -k --negotiate -u : --data-urlencode \"script=\$(cat $argv[2])\" $argv[1]/scriptText"
end
