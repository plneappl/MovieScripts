function setAspectRatio
  if [ "$argv[1]" = "" ]
    echo missing file
    return
  else if [ "$argv[2]" = "" ]
    echo missing aspect ratio
    return
  end
  
  set ffmpeg /mnt/c/Users/simon/Tools/FFMpeg/bin/ffmpeg.exe
  set input $argv[1]
  set inputName (,basename $argv[1])
  set output (dirname $argv[1])/"$inputName"_2.mp4
  echo $output
  $ffmpeg -i $input -aspect $argv[2] -c copy $output
  echo 'remove original? [yN]'
  read shouldContinue
  if [ "$shouldContinue" != "y" ]
    return
  end
  rm $input
  mv $output $input
end