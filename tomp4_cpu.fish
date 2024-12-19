function tomp4_cpu
	set ffmpeg /mnt/c/Users/simon/Tools/FFMpeg/bin/ffmpeg.exe
  set outDir $argv[1]
	set total (math (count $argv) - 1)
  set cntr 0
  set starttime (date +%s)
  echo 0 / $total
  echo "-----------------------"
	for i in $argv[2..-1]
		$ffmpeg \
		  -hide_banner \
#		  -loglevel fatal \
#			-hwaccel auto \
			-i $i \
			-c:v libx265 \
#			-preset slow \
			-crf 24 \
			-preset medium \
			-profile:v main10 \
			-pix_fmt yuv420p10le \
			-c:a libopus \
			-b:a 96k \
			-ac 2 \
#			-ac 6 \
			$outDir/(,basename $i).mp4
			or begin
				rm $outDir/(,basename $i).mp4
				return
			end
#		rm $i
#		return
		set cntr (math $cntr + 1)
    echo $cntr / $total
	  set curtime (date +%s)
		set elapsec (math $curtime - $starttime)
		set elapmin (math $elapsec / 60)
		set elaphour (math $elapmin / 60)
		set elapdays (math $elaphour / 24)
		set etasec (math $elapsec / $cntr "*" $total)
	  set etamin (math $etasec / 60)
    set etahour (math $etamin / 60)
    set etadays (math $etahour / 24)
		set etasecrem (math $etasec - $elapsec)
	  set etaminrem (math $etasecrem / 60)
    set etahourrem (math $etaminrem / 60)
    set etadaysrem (math $etahourrem / 24)
    echo "ETA tot "$etasec"s ("$etamin" min) ("$etahour"h) ("$etadays" days)"
    echo "Elapsed "$elapsec"s ("$elapmin" min) ("$elaphour"h) ("$elapdays" days)"
    echo "ETA rem "$etasecrem"s ("$etaminrem" min) ("$etahourrem"h) ("$etadaysrem" days)"
    echo "-----------------------"
  end
end