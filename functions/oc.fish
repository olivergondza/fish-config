function oc
  if [ (count $argv) -eq 0 ]
    oc project
    return 0
  end

  switch $argv[1]
    case {y,yaml}
      oc get -o yaml $argv[2..-1] | yq .
    case rsh
      # Set TERM inside the container for `oc rsh`
      env TERM=xterm oc $argv
    case '*'
      command env KUBECTL_COMMAND=oc kubecolor $argv
  end
end

function __ocp_sso_token_login
    command oc login --server $argv[1] --token (__ocp_sso_token $argv[1])
end

function __ocp_sso_token
  env REQUESTS_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt ocp-sso-token $argv[1]
end
