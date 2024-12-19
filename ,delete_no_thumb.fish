function ,delete_no_thumb
	for i in *.mp4 *.mkv
		set thumbname (,basename $i)
		if [ -f $thumbname.jpg ]
			continue
		else if [ -f $thumbname.jpeg ]
			mv $thumbname.jpeg $thumbname.jpg
			continue
		else if [ -f $i.jpg ]
			mv $i.jpg $thumbname.jpg
			continue
		else if [ -f $i.jpeg ]
			mv $i.jpeg $thumbname.jpg
			continue
		else if [ -f $thumbname.png ]
			continue
		else if [ -f $i.png ]
			continue
		end

    rm $i
  end
end