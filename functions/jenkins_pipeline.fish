function jenkins_pipeline -d "Link jenkins pipeline against running instance"

  # JENKINS_CRUMB is needed if your Jenkins master has CRSF protection enabled as it should
  set JENKINS_CRUMB (curl -LSs $argv[1]"/crumbIssuer/api/xml?xpath=concat(//crumbRequestField,\":\",//crumb)")

  # Use local file or second argument
  if set -q $argv[2]
    set JENKINS_FILE "Jenkinsfile"
  else
    set JENKINS_FILE $argv[2]
  end

  # Assuming "anonymous read access" has been enabled on your Jenkins instance.
  curl -X POST -H $JENKINS_CRUMB -F "jenkinsfile=<$JENKINS_FILE" $argv[1]/pipeline-model-converter/validate
end
