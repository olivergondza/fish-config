function oc --description "Switch oc clusters"
  if [ (count $argv) -eq 0 ]
    oc project
    return 0
  end

  switch $argv[1]
    case 4
      set server https://api.ocp4.prod.psi.redhat.com:6443
      command oc login --server $server --token (ocp-sso-token $server)
    case bm
      set server https://api.ocp-c1.prod.psi.redhat.com:6443
      command oc login --server $server --token (ocp-sso-token $server)
    case multilog
      for pod in (oc get pods | awk '$1 ~ /^'$argv[2]'/ && $3 == "Running" { print $1 }');
        command oc logs $pod | sed 's/^/'$pod': /'
      end
    case '*'
      command oc $argv
  end
end
