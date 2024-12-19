function emptyDirs
	for i in */
		if [ 0 -eq (count $i/*) ]
			echo $i
		end
	end
	for i in */
		if [ 1 -eq (count $i/*) ]; and test -d $i/*
			echo just one directory:  $i/*
		end
	end
end