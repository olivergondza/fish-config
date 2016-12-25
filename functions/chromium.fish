function chromium
	command chromium --ignore-certificate-errors $argv 2> /dev/null &
end
