function oc_run --description "Run interactive openshift pod"
  set IMAGE $argv[1]
  set POD_NAME "oc-run-$USER-"(random)
  set yaml "
kind: Pod
apiVersion: v1
metadata:
  name: $POD_NAME
labels:
  app: $POD_NAME
spec:
  containers:
  - name: $POD_NAME
    image: '$IMAGE'
    imagePullPolicy: Always
    command:
    - 'sleep'
    args:
    - 'inf'
  "

  oc apply -f (echo $yaml | psub)
  oc wait pod $POD_NAME --for=condition=ready --timeout=60s
  sleep 2
  oc get pod $POD_NAME
  oc rsh $POD_NAME
  oc delete pod $POD_NAME &
end
