function jira --description "Run jira with auth on"
    env JIRA_AUTH_TYPE=bearer JIRA_API_TOKEN=(pass show rh/issues.redhat.com/ogondza@redhat.com/jira-cli) jira $argv
end
