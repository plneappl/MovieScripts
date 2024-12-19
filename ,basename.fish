function ,basename
	basename (echo $argv[1] | sed 's/\.[^.]*$//')
end