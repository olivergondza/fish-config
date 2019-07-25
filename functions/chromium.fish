function chromium
	command chromium --ignore-certificate-errors --allow-file-access-from-files $argv 2> /dev/null &
end
