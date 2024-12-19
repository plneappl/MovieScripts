function concat
	set outputName $argv[1]
	set ffmpeg /mnt/c/Users/simon/Tools/FFMpeg/bin/ffmpeg.exe	
	for i in $argv[2..-1]
		$ffmpeg -i $i -c copy -bsf:v h264_mp4toannexb -f mpegts $i.ts; or begin
#		$ffmpeg -i $i -c copy -bsf:v hevc_mp4toannexb -f mpegts $i.ts; or begin
		  return
		end
		echo file \'$i.ts\' >> $outputName.txt
	end
	joe $outputName.txt
	$ffmpeg -f concat -safe 0 -i $outputName.txt -c copy $outputName.mp4
	for i in $argv[2..-1]
		rm $i.ts
	end
	rm $outputName.txt
end