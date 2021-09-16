function o --description "Switch oc clusters"
  if [ (count $argv) -eq 0 ]
    oc project
    return 0
  end

  switch $argv[1]
    case 4
      oc login -u ogondza -p (pass show rh/identity.corp.redhat.com/ogondza) \
          https://api.ocp4.prod.psi.redhat.com:6443
    case bm
      oc login -u ogondza -p (pass show rh/identity.corp.redhat.com/ogondza) \
          https://api.ocp-c1.prod.psi.redhat.com:6443
  end
end
