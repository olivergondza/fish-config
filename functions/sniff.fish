function sniff
	sudo tcpflow -s -c -i any host $argv;
end
