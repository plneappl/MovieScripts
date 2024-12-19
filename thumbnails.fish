function thumbnails
  set jobs 8
	set total (count *.mp4 *.mkv)
  set cntr 0
  set starttime (date +%s)
  echo 0 / $total
  
	for i in *.mp4 *.mkv
		set thumbname (,basename "$i")
		if [ -f "$thumbname.jpg" ]
		  set total (math $total - 1)
			continue
		else if [ -f "$thumbname.jpeg" ]
			mv "$thumbname.jpeg" "$thumbname.jpg"
		  set total (math $total - 1)
			continue
		else if [ -f "$i.jpg" ]
			mv "$i.jpg" "$thumbname.jpg"
		  set total (math $total - 1)
			continue
		else if [ -f "$i.jpeg" ]
			mv "$i.jpeg" "$thumbname.jpg"
		  set total (math $total - 1)
			continue
		else if [ -f "$thumbname.png" ]
			rm "$thumbname.png"
		else if [ -f "$i.png" ]
			rm $i.png
		end

    set remaining (math $total - $cntr - 1)

    if [ $remaining -gt $jobs ]
      sem -j$jobs \
        --id sem1 \
        vcsi \"$i\" \
        -w 2500 \
        -g 7x4 \
        --background-color 000000 \
        --metadata-font-color ffffff \
        --end-delay-percent 20 \
        --metadata-font /usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf \
# hwaccel is slow for short ffmpeg calls :(
#        --hw \
        -o \"$thumbname.jpg\"
    else
      sem -j$jobs \
        --id sem1 \
        vcsi \"$i\" \
        -w 2500 \
        -g 7x4 \
        --background-color 000000 \
        --metadata-font-color ffffff \
        --end-delay-percent 20 \
        --metadata-font /usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf \
        -o \"$thumbname.jpg\"
    end	
    
    set cntr (math $cntr + 1)

    echo "-----------------------"
    echo $cntr / $total
    if [ $cntr -gt (math 2 \* $jobs) ]
      set curtime (date +%s)
      set elapsec (math $curtime - $starttime)
      set elapmin (math $elapsec / 60)
      set elaphour (math $elapmin / 60)
      set esttimeperelem (math $elapsec / \( $cntr - $jobs \) )
      set etasec (math $esttimeperelem "*" $total)
      set etamin (math $etasec / 60)
      set etahour (math $etamin / 60)
      set etasecrem (math $etasec - $elapsec)
      set etaminrem (math $etasecrem / 60)
      set etahourrem (math $etaminrem / 60)
      echo "est/elm "$esttimeperelem"s"
      echo "est tot "$etasec"s ("$etamin" min) ("$etahour"h)"
      echo "elapsed "$elapsec"s ("$elapmin" min) ("$elaphour"h)"
      echo "est rem "$etasecrem"s ("$etaminrem" min) ("$etahourrem"h)"
  	end
  end
	sem --id sem1 --wait
	
	set curtime (date +%s)
  set elapsec (math $curtime - $starttime)
  set elapmin (math $elapsec / 60)
  set elaphour (math $elapmin / 60)
  echo "elapsed "$elapsec"s ("$elapmin" min) ("$elaphour"h)"
end