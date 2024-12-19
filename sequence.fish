function sequence
	set i 1
	for f in *
		mv $f (dirname $f)/(printf "%03d.%s" $i (filext $f))
		set i (expr $i + 1)
	end
end
