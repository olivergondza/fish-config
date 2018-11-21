function pstree -d "List the tree of running processes"
  ps -ef --forest \
  | grep -Pv '^root\s+\d+\s+[02]\s+' # Hide kernel processes
end
