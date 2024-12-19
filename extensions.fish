function extensions
	find . -type f -print | sed -e 's:^.*\.::' | sort --unique
end