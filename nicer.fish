#!/bin/fish
if [ $argv ]
  if [ (count $argv) != 1 ]           #check for only one argument
    exit
  else if [ -f $argv ]                #files get processed directly, the for loop will loop over exactly one file
    set searchIn $argv
    set searchPath (dirname $argv)
  else if [ -d $argv ]                #for directories, we process each file inside
    set searchIn $argv/*.*
    set searchPath $argv
  else                                #is there some other case? file not found or something...
    exit
  end
else                                  #no arguments ==> just use base path
  set searchIn *.*
  set searchPath .
end



#all keywords to delete, case insensitive, spaces instead of [._-]
set deletions              german dubbed x264 bluray web ac3 ac3md rip dts hd readnfo multi 'dd5 1' 'h 264' h264 dub '\(1\)' 
set deletions $deletions   wmv dvd ts 'blu ray' dd51 'aac2 0' aac avc remux xvid tv avi mp4 'dd2 0' 'read nfo' internal ituneshd
set deletions $deletions   dvdrip hdtv repack

set deletionChars          '\(' '\)' '\[' '\]'

for i in $searchIn
  set fn (basename $i)
  set extension '.'(echo $fn | sed -e 's:^.*\.::')
  set name ' '(echo $fn | sed -e 's:\.[^\.]*$::')' '
  
  #replace dots, dashes and underscores
  set nicerName (echo $name | sed -r 's:\.: :g' | sed -r 's:-: :g' | sed -r 's:_: :g')


  #remove all keywords
  for del in $deletions 
    #echo $del 
    set nicerName (echo $nicerName | sed -r "s: $del :  :gI")
  end

  #some special chars
  for del in $deletionChars
    set nicerName (echo $nicerName | sed -r "s:$del::gI")
  end

  #uppercase each word
  set nicerName (echo $nicerName | sed -r 's/\<./\U&/g')

  #remove all duplicate space
  set nicerName (echo $nicerName | sed -r 's: +: :g')

  #remove space at the start/end of the file name
  set nicerName (echo $nicerName | sed -r 's:^ +::')
  set nicerName (echo $nicerName | sed -r 's: +$::')$extension

  set destination $searchPath/$nicerName

  if [ $nicerName ]
    #what we are going to do
    echo $fn
    echo $destination
    echo '------------'
  
    #do it
    mv $i $destination
  else 
    echo "Something went wrong... We didn't process"
    echo $fn 
    echo "because we deleted the name (whoops!)"
    echo '------------'
  end
end