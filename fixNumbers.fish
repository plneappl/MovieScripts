function fixNumbers
  for i in */
	  if test (count $i/*) -gt 200
	  	continue
		end
	  
	  set x1 (find $i -regextype posix-extended -iregex "[^/]*/1[^0-9].*\\.(jpg|png|jpeg)")
	  set x2 (find $i -regextype posix-extended -iregex "[^/]*/1\\.(jpg|png|jpeg)")
	  
	  set x3 (find $i -regextype posix-extended -iregex "[^/]*/10.*\\.(jpg|png|jpeg)")
	  
    if test \( \( (count $x1) -gt 0 \) -o \( (count $x2) -gt 0 \) \) -a \( \( (count $x3) -gt 0 \) \)
      #echo $i
      #for j in $i/*
      #	echo '>' $j
			#end
      #echo
      pushd $i
      number
      popd
  	end
	end
end