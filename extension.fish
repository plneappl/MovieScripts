function extension
	while read line
		echo $line | sed -e 's:^.*\.::'
	end
end