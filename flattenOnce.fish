function flattenOnce
	set delAfter 0
	for a in $argv
		if [ $a = '-d' ]
			set delAfter 1	
		end
	end

	for i in *
		if [ -d $i ]
			for j in $i/*
				if [ -d $j ]
					set name (,basename $j)
					mkdir ./$name || true
					mv -n $j/* ./$name
					if [ $delAfter = 1 ]
						rm -d $j
					end
				else 
					mv -n $j .
				end
			end
			if [ $delAfter = 1 ]
				rm -d $i
			end
		end
	end
end