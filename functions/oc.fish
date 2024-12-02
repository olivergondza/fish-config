function oc
  if [ (count $argv) -eq 0 ]
    oc project
    return 0
  end

  switch $argv[1]
    # Switch oc clusters
    case dno
      __ocp_sso_token_login https://api.dno.ocp-hub.prod.psi.redhat.com:6443

    case dno-dev
      __ocp_sso_token_login https://api.dev-dno.ocp-hub.prod.psi.redhat.com:6443

    case bm
      __ocp_sso_token_login https://api.ocp-c1.prod.psi.redhat.com:6443

    case konflux
      oc login --server=https://api-toolchain-host-operator.apps.stone-prod-p02.hjvn.p1.openshiftapps.com/workspaces/data-and-operations \
          --token=(
              oc oidc-login get-token \
                  --oidc-issuer-url=https://keycloak-rhtap-auth.apps.stone-prod-p02.hjvn.p1.openshiftapps.com/auth/realms/redhat-external \
                  --oidc-client-id=cloud-services \
                  | jq -r '.status.token'
          )
    case multilog
      for pod in (oc get pods | awk '$1 ~ /^'$argv[2]'/ && $3 == "Running" { print $1 }');
        command oc logs $pod | sed 's/^/'$pod': /'
      end
    case {y,yaml}
      oc get -o yaml $argv[2..-1] | yq .
    case rsh
      # Set TERM inside the container for `oc rsh`
      env TERM=xterm oc $argv
    case '*'
      command oc $argv
  end
end

function __ocp_sso_token_login
    command oc login --server $argv[1] --token (__ocp_sso_token $argv[1])
end

function __ocp_sso_token
  env REQUESTS_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt ocp-sso-token $argv[1]
end
