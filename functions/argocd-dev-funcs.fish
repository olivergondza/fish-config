function argocd-local --description "Start local version of Argo CD"
    __argocd-check-in-repo || return 1
    __argocd-dev-cluster

    kubectl -n argocd apply -f manifests/install.yaml

    while not oc get secret argocd-initial-admin-secret
        echo >&2 "Waiting for Argo CD initialized"
        sleep 5
    end

    # Scaling down the workloads in the dummy deployment - we will only need the config and secrets
    kubectl -n argocd scale statefulset/argocd-application-controller --replicas 0
    kubectl -n argocd scale deployment/argocd-dex-server --replicas 0
    kubectl -n argocd scale deployment/argocd-repo-server --replicas 0
    kubectl -n argocd scale deployment/argocd-server --replicas 0
    kubectl -n argocd scale deployment/argocd-redis --replicas 0
    kubectl -n argocd scale deployment/argocd-applicationset-controller --replicas 0
    kubectl -n argocd scale deployment/argocd-notifications-controller --replicas 0

    set ARGO_PWD (oc -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)
    echo "argocd PWD: "$ARGO_PWD
    echo $ARGO_PWD | xclip # Put to clipboard for UI testing
    # The log in will only work after the `make start-local` progressed enough - run in background
    # Fish functions cannot run in background, so spawning child process
    env ARGO_PWD=$ARGO_PWD fish -c '
        while not dist/argocd login localhost:8080 --username=admin --password=$ARGO_PWD
            sleep 5
        end
        echo "Argocd client logged in"

        goreman run status
    ' &

    echo "Starting dev Argo CD"
    set -x ARGOCD_E2E_REPOSERVER_PORT 8088 # Prevent collision with the default - 8081
    set -x ARGOCD_APPLICATIONSET_CONTROLLER_ENABLE_PROGRESSIVE_SYNCS true # https://argo-cd.readthedocs.io/en/latest/operator-manual/applicationset/Progressive-Syncs/
    make start-local ARGOCD_GPG_ENABLED=false

    echo "Cleaning the env"
    k3d cluster delete argo-clstr
end

function argocd-e2e --description "Start E2E test env for Argo CD (make start-e2e-local)"
    __argocd-check-in-repo || return 1
    __argocd-dev-cluster

    make start-e2e-local ARGOCD_E2E_REPOSERVER_PORT=8088 COVERAGE_ENABLED=true ARGOCD_FAKE_IN_CLUSTER=true ARGOCD_E2E_K3S=true

    echo "Cleaning the env"
    k3d cluster delete argo-clstr
end

function __argocd-check-in-repo
    if not grep CLI_NAME=argocd Makefile > /dev/null
        echo >&2 "Not in an argo-cd repo"
        return 1
    end
    return 0
end

function __argocd-dev-cluster
    if not systemctl is-active --quiet docker
        systemctl start docker
    end

    set IP (getent hosts github.com | awk '{ print $1 }'| xargs ip route get | grep -oP "src \K[0-9\.]+")
    k3d cluster delete argo-clstr
    k3d cluster create argo-clstr --wait --k3s-arg '--disable=traefik@server:*' --api-port $IP:6550 -p 443:443@loadbalancer
    set -x KUBECONFIG /tmp/k3d--argo-cd--argo-clstr--kubeconfig.yaml
    k3d kubeconfig get argo-clstr > $KUBECONFIG

    oc cluster-info

    oc create namespace argocd
    oc config set-context --current --namespace=argocd
end
